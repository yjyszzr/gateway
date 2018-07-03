package com.dl.gate.filter;

import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;

import java.net.InetAddress;
import java.net.UnknownHostException;

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
            stringRedisTemplate.opsForHash().increment("access:" + url, DateUtil.getCurrentDate(DateUtil.yyyyMMdd), 1);
        } catch (Exception e) {
            log.warn("增加url访问记录失败", e);
        }
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
        	String ip = this.getIpAddr(request);
        	log.info("用户id:{},用户ip:{},请求地址为:{}, 请求信息为:{}", userId,ip==null?"":ip, request.getRequestURI(), str);
        }catch(Exception e) {
        	 log.warn("记录用户请求日志失败, url="+url, e);
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
    
    private String getIpAddr(HttpServletRequest request) { 
		String ip = request.getHeader("X-Real-IP");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
			ip = request.getHeader("X-Forwarded-For");   
		}  
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
			ip = request.getHeader("Proxy-Client-IP");   
		}   
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
			ip = request.getHeader("WL-Proxy-Client-IP");   
		}
		if (ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {   
		    ip = request.getHeader("HTTP_CLIENT_IP");   
		}  
		if (ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {   
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR");   
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
			ip = request.getRemoteAddr(); 
		}
		if(ip != null && ip.equals("127.0.0.1")){     
			//根据网卡取本机配置的IP     
			InetAddress inet=null;     
			try {     
				inet = InetAddress.getLocalHost();     
			} catch (UnknownHostException e) {     
				e.printStackTrace();     
			}     
			ip= inet.getHostAddress();     
		}  
		// 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割  
		if(ip != null && ip.length() > 15){    
			if(ip.indexOf(",")>0){     
				ip = ip.substring(0,ip.indexOf(","));     
			}     
		}     
		return ip;   
	}
}
