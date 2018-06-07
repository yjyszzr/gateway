package com.dl.gate.filter;

import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import com.dl.base.auth.client.config.UserAuthConfig;
import com.dl.base.auth.client.jwt.UserAuthUtil;
import com.dl.base.context.BaseContextHandler;
import com.dl.base.util.DateUtil;
import com.dl.base.util.SessionUtil;
import com.dl.base.util.jwt.IJWTInfo;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;

import lombok.extern.slf4j.Slf4j;

/**
 * 接入日志拦截器
 **/
@Slf4j
@Component
public class AccessLogFilter extends ZuulFilter {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private UserAuthConfig userAuthConfig;

    @Autowired
    private UserAuthUtil userAuthUtil;
    
    @Override
    public String filterType() {
        return PRE_TYPE;
    }

    @Override
    public int filterOrder() {
        return 0;
    }

    @Override
    public boolean shouldFilter() {
        return !RequestContext.getCurrentContext().getRequest().getMethod().equalsIgnoreCase("get");
    }

    @Override
    public Object run() {
        RequestContext ctx = RequestContext.getCurrentContext();
        HttpServletRequest request = ctx.getRequest();
        String url = request.getRequestURI();
        try {
        	FastJsonHttpMessageConverter converter = new FastJsonHttpMessageConverter();
        	ServletServerHttpRequest inputMessage = new ServletServerHttpRequest(request);
        	String str = (String) converter.read(String.class, inputMessage);
        	String userId = "-1";
        	IJWTInfo user = this.getUser(request, ctx);
        	BaseContextHandler.setToken(null);
        	if(user != null) {
        		userId = user.getUserId();
        	}
        	log.info("用户id:{},请求地址为:{}, 请求信息为:{}", userId, request.getRequestURI(), str);
            stringRedisTemplate.opsForHash().increment("access:" + url, DateUtil.getCurrentDate(DateUtil.yyyyMMdd), 1);
        } catch (Exception e) {
            log.warn("增加url访问记录失败", e);
        }
        return null;
    }
    
    private IJWTInfo getUser(HttpServletRequest request, RequestContext ctx) {
    	String authToken = request.getHeader(userAuthConfig.getTokenHeader());
    	if(StringUtils.isBlank(authToken)) {
    		return null;
    	}
    	try {
			BaseContextHandler.setToken(authToken);
			return userAuthUtil.getInfoFromToken(authToken);
		} catch (Exception e) {
		}
    	return null;
    }
}
