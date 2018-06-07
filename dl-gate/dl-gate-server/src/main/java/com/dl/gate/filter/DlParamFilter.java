package com.dl.gate.filter;

import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import com.dl.base.constant.CommonConstants;
import com.dl.base.model.Address;
import com.dl.base.model.UserDeviceInfo;
import com.dl.base.result.ResultGenerator;
import com.dl.base.util.JSONHelper;
import com.dl.base.util.SessionUtil;
import com.dl.gate.config.GateConfig;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.netflix.zuul.http.HttpServletRequestWrapper;
import com.netflix.zuul.http.ServletInputStreamWrapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 参数
 **/
@Component
@Slf4j
public class DlParamFilter extends ZuulFilter {

//    @Value("${spring.profiles.active}")
//    private String env;

    @Value("${zuul.prefix}")
    private String zuulPrefix;

    @Override
    public String filterType() {
        return PRE_TYPE;
    }

    @Override
    public int filterOrder() {
        return 2;
    }

    @Autowired
    private GateConfig gateConfig;

    @Override
    public boolean shouldFilter() {
        String url = RequestContext.getCurrentContext().getRequest().getRequestURI();
        url = url.substring(zuulPrefix.length());
        if (gateConfig.notTransParam(url)) {
            return false;
        }
        return RequestContext.getCurrentContext().sendZuulResponse()
                && "POST".equalsIgnoreCase(RequestContext.getCurrentContext().getRequest().getMethod());
    }

    @Override
    public Object run() {
        RequestContext ctx = RequestContext.getCurrentContext();
        HttpServletRequest request = ctx.getRequest();
        try {
            FastJsonHttpMessageConverter converter = new FastJsonHttpMessageConverter();
            ServletServerHttpRequest inputMessage = new ServletServerHttpRequest(request);
            ctx.addZuulRequestHeader("content-type", MediaType.APPLICATION_JSON_VALUE);
            String str = (String) converter.read(String.class, inputMessage);
            log.info("请求地址为：{}, 请求信息为：{}", request.getRequestURI(), str);
            JSONObject json = (JSONObject) converter.read(JSONObject.class, inputMessage);
//            log.info("请求地址为：{}, 请求信息为：{}", request.getRequestURI(), json);
            JSONObject body = json.getJSONObject("body");
            if (body == null || body.isEmpty()) {
                body = json;
            }
            byte[] arr = JSONObject.toJSONBytes(body);
            ctx.setRequest(new HttpServletRequestWrapper(request) {
                @Override
                public ServletInputStream getInputStream() {
                    return new ServletInputStreamWrapper(arr);
                }

                @Override
                public int getContentLength() {
                    return arr.length;
                }

                @Override
                public long getContentLengthLong() {
                    return arr.length;
                }

            });
            JSONObject header = json.getJSONObject("device");
            if (null != header) {
                Address address = header.toJavaObject(Address.class);
                ctx.addZuulRequestHeader(CommonConstants.HTTP_HEADER_ADDRESS, JSONHelper.bean2json(address));
                UserDeviceInfo deviceInfo = header.toJavaObject(UserDeviceInfo.class);
                ctx.addZuulRequestHeader(CommonConstants.HTTP_HEADER_DEVICE, JSONHelper.bean2json(deviceInfo));
            }
        } catch (Exception e) {
            log.error("请求解析失败", e);
            ctx.setSendZuulResponse(false);
            ctx.setResponseStatusCode(200);
            ctx.addZuulResponseHeader("content-type", MediaType.APPLICATION_JSON_UTF8_VALUE);
            ctx.setResponseBody(JSONHelper.bean2json(ResultGenerator.genBadRequestResult("请求参数异常")));
            return null;
        }

        return null;
    }
}
