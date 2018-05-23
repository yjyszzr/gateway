package com.dl.gate.config;

import com.dl.gate.dao.GateApiConfigDao;
import com.dl.gate.model.GateApiConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * ${DESCRIPTION}
 **/
@Component
@Slf4j
public class GateConfig {
    /**
     * 禁止访问URL
     */
    private volatile Set<String> allowUrl;


    /**
     * 需要鉴权的url
     */
    private volatile Set<String> authUrl;

    /**
     * 需要进行参数转换的url
     */
    private volatile Set<String> paramNotTransUrl;

    /**
     * 首次加载完成
     */
    private volatile boolean firstLoaded = false;

    /**
     * 判断url是否禁止通过网关访问
     *
     * @param url url地址
     * @return true 禁止通过网关访问
     */
    public Boolean allowAccess(String url) {
        if (!firstLoaded) {
            load();
        }
        return allowUrl.contains(url);
    }

    /**
     * 判断URL是否需要校验已经登录
     *
     * @param url 请求地址
     * @return true 需要校验用户登录状态
     */
    public boolean needAuth(String url) {
        if (!firstLoaded) {
            load();
        }
        return authUrl.contains(url);
    }

    /**
     * 是否需要参数转换
     *
     * @param url 请求地址
     * @return 是否需要进行参数转换
     */
    public boolean notTransParam(String url) {
        if (!firstLoaded) {
            load();
        }
        return paramNotTransUrl.contains(url);
    }

    @Resource
    private GateApiConfigDao gateApiConfigDao;


    /**
     * 加载配置
     */
    public synchronized void load() {
        if (!firstLoaded) {
            reload();
            firstLoaded = true;
        }
    }

    public void reload() {
        log.info("开始加载网关配置");
        List<GateApiConfig> gateApiConfigs = gateApiConfigDao.selectAll();
        allowUrl = gateApiConfigs.stream().filter(gateApiConfig -> gateApiConfig.getCanAccess()).map(GateApiConfig::getApi).collect(Collectors.toSet());
        log.info("&&&&&&&&allowUrl size="+allowUrl.size());
        authUrl = gateApiConfigs.stream().filter(GateApiConfig::getAuthFilter).map(GateApiConfig::getApi).collect(Collectors.toSet());
        log.info("&&&&&&&&authUrl size="+authUrl.size());
        paramNotTransUrl = gateApiConfigs.stream().filter(gateApiConfig -> !gateApiConfig.getParamFilter()).map(GateApiConfig::getApi).collect(Collectors.toSet());
        log.info("网关加载结束");
    }
}
