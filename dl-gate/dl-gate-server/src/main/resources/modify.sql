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

insert into dl_gate_api_config values(1, '/order/createOrder', 1, 1, 1, '创建订单');
insert into dl_gate_api_config values(2, '/order/getOrderDetail', 1, 1, 1, '订单详情');
insert into dl_gate_api_config values(3, '/order/getOrderInfoByOrderSn', 1, 0, 1, '根据订单编号查询订单数据');
insert into dl_gate_api_config values(4, '/order/getOrderInfoList', 1, 1, 1, '根据订单状态查询订单列表');
insert into dl_gate_api_config values(5, '/order/getOrderWithDetailByOrderSn', 1, 0, 1, '根据订单编号查询订单及订单详情');
insert into dl_gate_api_config values(6, '/order/getOrderWithUserAndMoney', 1, 0, 1, '获取中奖用户及奖金');
insert into dl_gate_api_config values(7, '/order/getTicketScheme', 1, 1, 1, '查询出票方案');
insert into dl_gate_api_config values(8, '/order/orderSnListGoPrintLottery', 1, 0, 1, '准备出票的订单列表');
insert into dl_gate_api_config values(9, '/order/queryOrderSnListByStatus', 1, 0, 1, '根据订单状态和支付状态查询订单号');
insert into dl_gate_api_config values(10, '/order/updateOrderInfo', 1, 0, 1, '支付成功修改订单信息');
insert into dl_gate_api_config values(11, '/order/updateOrderInfoByExchangeReward', 1, 0, 1, '兑奖时，修改订单数据');
insert into dl_gate_api_config values(12, '/order/updateOrderInfoByMatchResult', 1, 0, 1, '开奖后，修改订单数据');
insert into dl_gate_api_config values(13, '/order/updateOrderInfoByPrint', 1, 0, 1, '出票成功，修改订单数据');
insert into dl_gate_api_config values(99, '/order/detail/selectIssuesMatchInTodayOrder', 1, 0, 1, '更新订单状态公共方法');

insert into dl_gate_api_config values(14, '/payment/app', 1, 1, 1, 'app支付调用');
insert into dl_gate_api_config values(15, '/payment/query', 1, 1, 1, '支付订单结果 查询');
insert into dl_gate_api_config values(16, '/payment/recharge', 1, 1, 1, 'app充值调用');
insert into dl_gate_api_config values(17, '/payment/withdraw', 1, 1, 1, '提现');
insert into dl_gate_api_config values(18, '/payment/rollbackOrderAmount', 0, 0, 1, '回退订单金额');
insert into dl_gate_api_config values(19, '/payment/withdraw/add', 0, 1, 1, '添加提现进度');
insert into dl_gate_api_config values(20, '/payment/withdraw/list', 1, 1, 1, '提现进度');
insert into dl_gate_api_config values(21, '/payment/wxpay/notify', 0, 0, 0, '回调');

insert into dl_gate_api_config values(22, '/dl/article/detail', 1, 0, 1, '资讯详情');
insert into dl_gate_api_config values(23, '/dl/article/list', 1, 0, 1, '资讯首页');
insert into dl_gate_api_config values(24, '/dl/article/queryArticlesByIds', 1, 0, 1, '前端不用，根据文章id集合查询文章列表');
insert into dl_gate_api_config values(25, '/dl/article/relatedArticles', 1, 0, 1, '相关文章');
insert into dl_gate_api_config values(26, '/dl/league/match/asia/list', 1, 0, 1, '亚盘信息');
insert into dl_gate_api_config values(27, '/dl/league/match/asia/refresh', 0, 0, 1, '亚盘信息刷新');
insert into dl_gate_api_config values(28, '/dl/league/match/dao/xiao/list', 1, 0, 1, '大小球信息');
insert into dl_gate_api_config values(29, '/dl/league/match/europe/list', 1, 0, 1, '欧赔信息');
insert into dl_gate_api_config values(30, '/dl/league/match/europe/refresh', 0, 0, 1, '欧赔刷新 ');
insert into dl_gate_api_config values(31, '/dl/league/match/result/queryMatchResultByPlayCode', 0, 0, 1, '联赛结果');
insert into dl_gate_api_config values(32, '/dl/league/match/result/queryMatchResultsByPlayCodes', 0, 0, 1, '联赛结果');
insert into dl_gate_api_config values(33, '/dl/league/match/result/refresh', 0, 0, 1, '联赛结果刷新');
insert into dl_gate_api_config values(34, '/dl/league/team/list', 1, 0, 1, '球队信息');
insert into dl_gate_api_config values(35, '/dl/match/support/refresh', 0, 0, 1, '支持率的刷新');
insert into dl_gate_api_config values(36, '/lottery/hall/getHallData', 1, 0, 1, '彩票大厅数据');
insert into dl_gate_api_config values(37, '/lottery/hall/getHallMixData', 1, 0, 1, '获取彩票大厅数据和咨询列表数据');
insert into dl_gate_api_config values(38, '/lottery/hall/getPlayClassifyList', 1, 0, 1, '获取彩票玩法列表');
insert into dl_gate_api_config values(39, '/lottery/match/filterConditions', 1, 0, 1, '筛选条件');
insert into dl_gate_api_config values(40, '/lottery/match/getBetInfo', 1, 0, 1, '投注');
insert into dl_gate_api_config values(41, '/lottery/match/getBetInfoByOrderSn', 0, 1, 1, '通过订单号读取投注信息');
insert into dl_gate_api_config values(42, '/lottery/match/getMatchList', 1, 0, 1, '赛事列表');
insert into dl_gate_api_config values(43, '/lottery/match/matchTeamInfos', 1, 0, 1, '球队分析详情');
insert into dl_gate_api_config values(44, '/lottery/match/matchTeamInfosSum', 1, 0, 1, '球队分析总结');
insert into dl_gate_api_config values(45, '/lottery/match/queryMatchResult', 1, 0, 1, '比赛结果');
insert into dl_gate_api_config values(46, '/lottery/match/saveBetInfo', 1, 1, 1, '保存投注信息');
insert into dl_gate_api_config values(47, '/lottery/match/saveMatchList', 0, 0, 1, '攫取赛事列表');
insert into dl_gate_api_config values(48, '/lottery/money/getCountAndMoney', 1, 1, 1, '获取彩票注数及金额');
insert into dl_gate_api_config values(49, '/lottery/print/callbackStake', 0, 0, 0, '投注结果通知');
insert into dl_gate_api_config values(50, '/lottery/print/queryAccount', 1, 0, 1, '账户余额查询');
insert into dl_gate_api_config values(51, '/lottery/print/queryIssue', 1, 0, 1, '其次查询');
insert into dl_gate_api_config values(52, '/lottery/print/queryPrizeFile', 1, 0, 1, '期次中奖文件查询');
insert into dl_gate_api_config values(53, '/lottery/print/queryStake', 1, 0, 1, '投注结果查询');
insert into dl_gate_api_config values(54, '/lottery/print/queryStakeFile', 1, 0, 1, '期次投注对奖文件查询');
insert into dl_gate_api_config values(55, '/lottery/print/save', 0, 1, 1, '生成预出票信息');
insert into dl_gate_api_config values(56, '/lottery/print/toStake', 0, 0, 1, '投注接口');
insert into dl_gate_api_config values(57, '/lottery/reward/queryRewardByIssue', 0, 0, 1, '根据期次，查询审核通过的开奖数据');
insert into dl_gate_api_config values(58, '/lottery/reward/resolveTxt', 0, 0, 1, '解析中奖文件');
insert into dl_gate_api_config values(59, '/lottery/reward/saveRewardData', 0, 0, 1, '根据场次id拉取中奖数据');
insert into dl_gate_api_config values(60, '/lottery/reward/toAwarding', 0, 0, 1, '兑奖接口');


insert into dl_gate_api_config values(61, '/user/account/rollbackChangeUserAccountByCreateOrder', 1, 1, 1, '回滚下单时的账户变动：目前仅红包置为未使用');
insert into dl_gate_api_config values(62, '/user/account/createUserWithdraw', 1, 1, 1,'用户生成提现单');
insert into dl_gate_api_config values(63, '/user/collect/isCollect', 1, 1, 1, '用户收藏列表');
insert into dl_gate_api_config values(64, '/user/real/realNameAuth', 1, 1, 1,'实名认证');
insert into dl_gate_api_config values(65, '/user/bank/addBankCard', 1, 1, 1,'添加银行卡');
insert into dl_gate_api_config values(66, '/user/bank/updateUserBankDefault', 1, 1, 1,'设置银行卡为当前默认');
insert into dl_gate_api_config values(67, '/user/account/createReCharege', 1, 1, 1, '用户生成充值单');
insert into dl_gate_api_config values(68, '/user/account/rollbackUserAccountChangeByPay', 1, 1, 1, '余额支付或混合支付失败回滚账户的余额');
insert into dl_gate_api_config values(69, '/user/real/userRealInfo', 1, 1, 1, '查询实名认证信息');
insert into dl_gate_api_config values(70, '/user/bonus/queryValidBonusList', 1, 1, 1, '查询用户有效的红包列表');
insert into dl_gate_api_config values(71, '/user/account/getUserAccountList', 1, 1, 1, '查询用户账户明细列表');
insert into dl_gate_api_config values(72, '/user/getTokenByMobile', 1, 1, 1, '根据手机号获取tokeninsert into dl_gate_api_config values(60, 不提供调用)');
insert into dl_gate_api_config values(73, '/user/userInfoExceptPass', 1, 1, 1, '查询用户信息除了登录密码和支付密码');
insert into dl_gate_api_config values(74, '/user/account/countMoneyCurrentMonth', 1, 1, 1, '统计当月的各个用途的资金和');
insert into dl_gate_api_config values(75, '/user/account/changeUserAccountByPay', 1, 1, 1, '余额支付引起的账户余额变动');
insert into dl_gate_api_config values(76, '/login/loginBySms', 1, 0, 1, '短信验证码登录');
insert into dl_gate_api_config values(77, '/user/collect/list', 1, 1, 1, '用户收藏列表');
insert into dl_gate_api_config values(78, '/user/bonus/queryBonusListByStatus', 1, 1, 1, '根据状态查询有效的红包集合');
insert into dl_gate_api_config values(79, '/user/account/updateReCharege', 1, 1, 1,'更新用户充值单');
insert into dl_gate_api_config values(80, '/user/sys/querySysConfig', 1, 0, 1,'根据平台和业务版本查询当前版本是否开启');
insert into dl_gate_api_config values(81, '/user/account/updateUserWithdraw', 1, 1, 1, '更新用户提现单');
insert into dl_gate_api_config values(82, '/user/collect/delete', 1, 1, 1, '取消收藏');
insert into dl_gate_api_config values(83, '/user/bank/deleteUserBank', 1, 1, 1, '删除银行卡');
insert into dl_gate_api_config values(84, '/sms/sendSmsCode', 1, 0, 1, '发送短信验证码');
insert into dl_gate_api_config values(85, '/user/account/batchUpdateUserAccount', 1, 1, 1, '批量更新用户账户');
insert into dl_gate_api_config values(86, '/user/updateLoginPass', 1, 1, 1,'修改用户登录密码');
insert into dl_gate_api_config values(87, '/user/account/changeUserAccountByCreateOrder', 1, 1, 1, '下单时的账户变动：目前仅红包置为已使用');
insert into dl_gate_api_config values(88, '/user/collect/add', 1, 1, 1, '添加收藏');
insert into dl_gate_api_config values(89, '/user/bank/queryUserBank', 1, 1, 1, '查询银行卡');
insert into dl_gate_api_config values(90, '/user/message/list', 1, 1, 1, '用户消息列表');
insert into dl_gate_api_config values(91, '/user/bonus/queryUserBonus', 1, 1, 1, '根据userBonusId查询单个红包');
insert into dl_gate_api_config values(92, '/login/loginByPass', 1, 0, 1, '密码登录');
insert into dl_gate_api_config values(93, '/user/bank/queryWithDrawShow', 1, 1, 1, '提现界面的数据显示');
insert into dl_gate_api_config values(94, '/user/account/updateUserAccount', 1, 1, 1, '更新用户账户');
insert into dl_gate_api_config values(95, '/user/validateMobile', 1, 0, 1, '校验手机号');
insert into dl_gate_api_config values(96, '/login/logout', 1, 1, 1, '用户注销');
insert into dl_gate_api_config values(97, '/user/bank/queryUserBankList', 1, 1, 1, '查询银行卡列表');
insert into dl_gate_api_config values(98, '/user/register', 1, 0, 1, '注册');
