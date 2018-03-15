package com.dl.gate.model;

import lombok.Data;

import java.io.Serializable;

/**
 * 网关接口配置
 */
@Data
public class GateApiConfig implements Serializable {

    private static final long serialVersionUID = 356911224180992506L;
    /**
     * 主键
     */
    private Integer id;

    /**
     * api地址
     */
    private String api;

    /**
     * 是否允许访问
     */

    private Boolean canAccess;

    /**
     * 是否需要登录校验
     */

    private Boolean authFilter;

    /**
     * 是否进行参数预处理
     */
    private Boolean paramFilter;


}