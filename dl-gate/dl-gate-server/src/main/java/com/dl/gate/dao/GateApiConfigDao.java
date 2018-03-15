package com.dl.gate.dao;

import com.dl.gate.model.GateApiConfig;

import java.util.List;

/**
 * 网关配置db服务类
 *
 * @author 李洪春
 * @create 2017/12/25 16:14
 **/
public interface GateApiConfigDao {
    /**
     * 查询全部配置
     *
     * @return 配置列表
     */
    List<GateApiConfig> selectAll();
}
