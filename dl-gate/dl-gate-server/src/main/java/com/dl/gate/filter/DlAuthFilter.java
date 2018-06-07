package com.dl.gate.filter;

import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;

import com.aliyun.oss.ServiceException;
import com.dl.base.auth.client.config.UserAuthConfig;
import com.dl.base.auth.client.jwt.UserAuthUtil;
import com.dl.base.context.BaseContextHandler;
import com.dl.base.result.ResultGenerator;
import com.dl.base.util.JSONHelper;
import com.dl.base.util.jwt.IJWTInfo;
import com.dl.gate.config.GateConfig;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;

import lombok.extern.slf4j.Slf4j;

/**
 * 鉴权拦截器
 **/
@Slf4j
@Component
public class DlAuthFilter extends ZuulFilter {


    @Value("${spring.profiles.active}")
    private String env;

    private final static String USER_SESSION_PREFIX = "US:";

    @Autowired
    private UserAuthConfig userAuthConfig;

    @Autowired
    private UserAuthUtil userAuthUtil;

    @Value("${gate.ignore.startWith:}")
    private String startWith;

    @Value("${zuul.prefix:}")
    private String zuulPrefix;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private GateConfig gateConfig;

    private static final long MAX_TIME = 1000L * 60L * 60L * 24L;

    @Override
    public String filterType() {
        return PRE_TYPE;
    }

    @Override
    public int filterOrder() {
        return 1;
    }

    @Override
    public boolean shouldFilter() {
        return RequestContext.getCurrentContext().sendZuulResponse();
    }


    @Override
    public Object run() {
        RequestContext ctx = RequestContext.getCurrentContext();
        HttpServletRequest request = ctx.getRequest();
        final String requestUri = request.getRequestURI().substring(zuulPrefix.length());
//        log.info("test dyp : " + requestUri);
        // 测试环境放过get请求  && "dev".equalsIgnoreCase(env)
        if (request.getMethod().equalsIgnoreCase("get")) {
            return null;
        }

        //判断url是否禁止通过网关访问
        if (!gateConfig.allowAccess(requestUri) && !"dev1".equals(env)) {
            ctx.setResponseBody(JSONHelper.bean2json(ResultGenerator.genForbiddenResult("非法请求")));
            ctx.setResponseStatusCode(HttpStatus.SC_FORBIDDEN);
            ctx.addZuulResponseHeader("content-type", MediaType.APPLICATION_JSON_UTF8_VALUE);
            ctx.setSendZuulResponse(false);
            return null;
        }


        String authToken = request.getHeader(userAuthConfig.getTokenHeader());
        log.info("请求地址为{}， token为{}", requestUri, authToken);
        BaseContextHandler.setToken(null);
        // 不进行拦截的地址,直接放过
        boolean needAuth = gateConfig.needAuth(requestUri) && !"dev1".equalsIgnoreCase(env);
        try {
            if (StringUtils.isBlank(authToken)) {
                if (needAuth) {
                    setLoginResult(ctx);
                }
                return null;
            }
            IJWTInfo jwtUser = getJWTUser(authToken, ctx);
            Object value = stringRedisTemplate.opsForHash().get(USER_SESSION_PREFIX + jwtUser.getUserId(), jwtUser.getUnique());
            if (null == value) {
                if (needAuth) {
                    setLoginResult(ctx);
                }
                return null;
            } else {
                Long time = Long.parseLong(value.toString());
                if (System.currentTimeMillis() - time > MAX_TIME) {
                    stringRedisTemplate.opsForHash().delete(USER_SESSION_PREFIX + jwtUser.getUserId(), jwtUser.getUnique());
                    if (needAuth) {
                        setLoginResult(ctx);
                    }
                    return null;
                } else {
                    stringRedisTemplate.opsForHash().put(USER_SESSION_PREFIX + jwtUser.getUserId(), jwtUser.getUnique(), "" + System.currentTimeMillis());
                    setToken(ctx, authToken);
                }
            }

        } catch (Exception e) {
            if (e instanceof ServiceException) {
                log.error("token 异常, token为：{}", authToken);
            } else {
                log.error("token处理异常", e);
            }
            if (needAuth) {
                setLoginResult(ctx);
            }
            return null;
        }
        return null;
    }


    /**
     * 返回session中的用户信息
     *
     * @param authToken token
     * @param ctx
     * @return
     */
    private IJWTInfo getJWTUser(String authToken, RequestContext ctx) throws Exception {
        BaseContextHandler.setToken(authToken);
        return userAuthUtil.getInfoFromToken(authToken);
    }

    /**
     * 鉴权失败返回
     *
     * @param ctx 请求
     */
    public void setLoginResult(RequestContext ctx) {
        ctx.setResponseStatusCode(200);
        ctx.setSendZuulResponse(false);
        ctx.addZuulResponseHeader("content-type", MediaType.APPLICATION_JSON_UTF8_VALUE);
        ctx.setResponseBody(JSONHelper.bean2json(ResultGenerator.genNeedLoginResult("请登录")));
    }

    public void setToken(RequestContext ctx, String token) {
        ctx.addZuulRequestHeader("token", token);
    }


}
