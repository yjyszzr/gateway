package com.dl.gate;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.Primary;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.dl.base.auth.client.config.UserAuthConfig;
import com.dl.base.auth.client.jwt.UserAuthUtil;
import com.dl.base.filter.ServerSelectedFilter;
import com.dl.base.filter.ServiceDependConfig;
import com.dl.gate.config.UserPrincipal;
import com.github.wxiaoqi.gate.ratelimit.config.IUserPrincipal;

/**
 * @author Ace
 * @date 2017/6/2
 */
@SpringBootApplication
@EnableDiscoveryClient
@EnableZuulProxy
@EnableScheduling
//@EnableAceGateRateLimit
@Import(UserAuthUtil.class)
@MapperScan("com.dl.gate.dao")
//@EnableApolloConfig
public class GateBootstrap {
    public static void main(String[] args) {
        SpringApplication.run(GateBootstrap.class, args);
    }

    @Bean
    @Primary
    IUserPrincipal userPrincipal() {
        return new UserPrincipal();
    }

    @Bean
    UserAuthConfig getUserAuthConfig() {
        return new UserAuthConfig();
    }

    @Bean
    ServiceDependConfig getServiceDependConfig() {
        return new ServiceDependConfig();
    }

    @Bean
    ServerSelectedFilter getServerSelectedFilter() {
        return new ServerSelectedFilter();
    }


}
