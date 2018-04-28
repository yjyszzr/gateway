CREATE TABLE dl_gate_api_config
(
	id INT AUTO_INCREMENT
		PRIMARY KEY,
	api VARCHAR(128) NOT NULL COMMENT 'api地址',
	can_access TINYINT(1) DEFAULT '1' NOT NULL COMMENT '是否允许访问, 1、表示该接口可以通过网关访问，0表示该接口不能通过网关访问（黑名单）',
	auth_filter TINYINT(1) DEFAULT '1' NULL COMMENT '是否需要登录校验, 1、接口需要进行登录校验 0、不进行登录校验（无需登录访问）',
	param_filter TINYINT(1) DEFAULT '1' NULL COMMENT '是否进行参数预处理, 1、需要进行参数加工，将body字段作为消息体，并从header中获取地址信息',
	remark VARCHAR(256) NULL COMMENT '备注信息',
	CONSTRAINT pgt_gate_api_api_uindex
		UNIQUE (api)
)
COMMENT '网关接口配置' ENGINE=InnoDB CHARSET=utf8
;

insert into dl_gate_api_config values(1, '/order/createOrder', 1, 1, 1, '');
insert into dl_gate_api_config values(2, '/order/getOrderDetail', 1, 1, 1, '');
insert into dl_gate_api_config values(3, '/order/getOrderInfoByOrderSn', 1, 0, 1, '');
insert into dl_gate_api_config values(4, '/order/getOrderInfoList', 1, 1, 1, '');
insert into dl_gate_api_config values(5, '/order/getOrderWithDetailByOrderSn', 1, 0, 1, '');
insert into dl_gate_api_config values(6, '/order/getOrderWithUserAndMoney', 1, 0, 1, '');
insert into dl_gate_api_config values(7, '/order/getTicketScheme', 1, 1, 1, '');
insert into dl_gate_api_config values(8, '/order/orderSnListGoPrintLottery', 1, 0, 1, '');
insert into dl_gate_api_config values(9, '/order/updateOrderInfo', 1, 0, 1, '');
insert into dl_gate_api_config values(10, '/order/updateOrderInfoByExchangeReward', 1, 0, 1, '');
insert into dl_gate_api_config values(11, '/order/updateOrderInfoByMatchResult', 1, 0, 1, '');
insert into dl_gate_api_config values(12, '/order/updateOrderInfoByPrint', 1, 0, 1, '');
insert into dl_gate_api_config values(13, '/order/detail/selectIssuesMatchInTodayOrder', 1, 0, 1, '');

insert into dl_gate_api_config values(14, '/payment/app', 1, 1, 1, '');
insert into dl_gate_api_config values(15, '/payment/query', 1, 1, 1, '');
insert into dl_gate_api_config values(16, '/payment/recharge', 1, 1, 1, '');
insert into dl_gate_api_config values(17, '/payment/withdraw', 1, 1, 1, '');
insert into dl_gate_api_config values(18, '/payment/rollbackOrderAmount', 1, 0, 1, '');
insert into dl_gate_api_config values(19, '/payment/withdraw/add', 1, 0, 1, '');
insert into dl_gate_api_config values(20, '/payment/withdraw/list', 1, 1, 1, '');
insert into dl_gate_api_config values(21, '/payment/wxpay/notify', 0, 0, 0, '');

insert into dl_gate_api_config values(22, '/dl/article/detail', 1, 1, 1, '');
insert into dl_gate_api_config values(23, '/dl/article/list', 1, 1, 1, '');
insert into dl_gate_api_config values(24, '/dl/article/queryArticlesByIds', 1, 1, 1, '');
insert into dl_gate_api_config values(25, '/dl/article/relatedArticles', 1, 1, 1, '');
insert into dl_gate_api_config values(26, '/dl/league/match/asia/list', 1, 1, 1, '');
insert into dl_gate_api_config values(27, '/dl/league/match/asia/refresh', 1, 1, 1, '');
insert into dl_gate_api_config values(28, '/dl/league/match/dao/xiao/list', 1, 1, 1, '');
insert into dl_gate_api_config values(29, '/dl/league/match/europe/list', 1, 1, 1, '');
insert into dl_gate_api_config values(30, '/dl/league/match/europe/refresh', 1, 1, 1, '');
insert into dl_gate_api_config values(31, '/dl/league/match/result/queryMatchResultByPlayCode', 1, 1, 1, '');
insert into dl_gate_api_config values(32, '/dl/league/match/result/refresh', 1, 1, 1, '');
insert into dl_gate_api_config values(33, '/dl/league/team/list', 1, 1, 1, '');
insert into dl_gate_api_config values(34, '/dl/match/support/refresh', 1, 1, 1, '');
insert into dl_gate_api_config values(35, '/lottery/hall/getHallData', 1, 1, 1, '');
insert into dl_gate_api_config values(36, '/lottery/hall/getHallMixData', 1, 1, 1, '');
insert into dl_gate_api_config values(37, '/lottery/hall/getPlayClassifyList', 1, 1, 1, '');
insert into dl_gate_api_config values(38, '/lottery/match/filterConditions', 1, 1, 1, '');
insert into dl_gate_api_config values(39, '/lottery/match/getBetInfo', 1, 1, 1, '');
insert into dl_gate_api_config values(40, '/lottery/match/getBetInfoByOrderSn', 1, 1, 1, '');
insert into dl_gate_api_config values(41, '/lottery/match/getMatchList', 1, 1, 1, '');
insert into dl_gate_api_config values(42, '/lottery/match/matchTeamInfos', 1, 1, 1, '');
insert into dl_gate_api_config values(43, '/lottery/match/matchTeamInfosSum', 1, 1, 1, '');
insert into dl_gate_api_config values(44, '/lottery/match/queryMatchResult', 1, 1, 1, '');
insert into dl_gate_api_config values(45, '/lottery/match/saveBetInfo', 1, 1, 1, '');
insert into dl_gate_api_config values(46, '/lottery/match/saveMatchList', 1, 1, 1, '');
insert into dl_gate_api_config values(47, '/lottery/money/getCountAndMoney', 1, 1, 1, '');
insert into dl_gate_api_config values(48, '/lottery/print/callbackStake', 0, 0, 0, '');
insert into dl_gate_api_config values(49, '/lottery/print/queryAccount', 1, 1, 1, '');
insert into dl_gate_api_config values(50, '/lottery/print/queryIssue', 1, 1, 1, '');
insert into dl_gate_api_config values(51, '/lottery/print/queryPrizeFile', 1, 1, 1, '');
insert into dl_gate_api_config values(52, '/lottery/print/queryStake', 1, 1, 1, '');
insert into dl_gate_api_config values(53, '/lottery/print/queryStakeFile', 1, 1, 1, '');
insert into dl_gate_api_config values(54, '/lottery/print/save', 1, 1, 1, '');
insert into dl_gate_api_config values(55, '/lottery/print/toStake', 1, 1, 1, '');
insert into dl_gate_api_config values(56, '/lottery/reward/queryRewardByIssue', 1, 1, 1, '');
insert into dl_gate_api_config values(57, '/lottery/reward/resolveTxt', 1, 1, 1, '');
insert into dl_gate_api_config values(58, '/lottery/reward/saveRewardData', 1, 1, 1, '');
insert into dl_gate_api_config values(59, '/lottery/reward/toAwarding', 1, 1, 1, '');
insert into dl_gate_api_config values(60, '', 1, 1, 1, '');
insert into dl_gate_api_config values(61, '', 1, 1, 1, '');
insert into dl_gate_api_config values(62, '', 1, 1, 1, '');
insert into dl_gate_api_config values(63, '', 1, 1, 1, '');
insert into dl_gate_api_config values(64, '', 1, 1, 1, '');
insert into dl_gate_api_config values(65, '', 1, 1, 1, '');
insert into dl_gate_api_config values(66, '', 1, 1, 1, '');
insert into dl_gate_api_config values(67, '', 1, 1, 1, '');
insert into dl_gate_api_config values(68, '', 1, 1, 1, '');