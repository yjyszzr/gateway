package com.dl.gate.job;

import com.dl.gate.config.GateConfig;
import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.handler.IJobHandler;
import com.xxl.job.core.handler.annotation.JobHander;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 网关配置刷新job
 **/
@JobHander("gateConfigRefreshJob")
@Component
public class GateConfigRefresh extends IJobHandler {

    @Resource
    private GateConfig gateConfig;

    @Override
    public ReturnT<String> execute(String... strings) {
        gateConfig.reload();
        return ReturnT.SUCCESS;
    }
}
