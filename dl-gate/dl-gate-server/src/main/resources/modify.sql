
DROP TABLE IF EXISTS `dl_gate_api_config`;
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

insert into dl_gate_api_config values(1, '/order/order/createOrder', 1, 1, 1, '创建订单');
insert into dl_gate_api_config values(2, '/order/order/getOrderDetail', 1, 1, 1, '订单详情');
insert into dl_gate_api_config values(3, '/order/order/getOrderInfoByOrderSn', 1, 0, 1, '根据订单编号查询订单数据');
insert into dl_gate_api_config values(4, '/order/order/getOrderInfoList', 1, 1, 1, '根据订单状态查询订单列表');
insert into dl_gate_api_config values(5, '/order/order/getOrderWithDetailByOrderSn', 1, 0, 1, '根据订单编号查询订单及订单详情');
insert into dl_gate_api_config values(6, '/order/order/getOrderWithUserAndMoney', 1, 0, 1, '获取中奖用户及奖金');
insert into dl_gate_api_config values(7, '/order/order/getTicketScheme', 1, 1, 1, '查询出票方案');
insert into dl_gate_api_config values(8, '/order/order/orderSnListGoPrintLottery', 1, 0, 1, '准备出票的订单列表');
insert into dl_gate_api_config values(9, '/order/order/queryOrderSnListByStatus', 1, 0, 1, '根据订单状态和支付状态查询订单号');
insert into dl_gate_api_config values(10, '/order/order/updateOrderInfo', 1, 0, 1, '支付成功修改订单信息');
insert into dl_gate_api_config values(11, '/order/order/updateOrderInfoByExchangeReward', 1, 0, 1, '兑奖时，修改订单数据');
insert into dl_gate_api_config values(12, '/order/order/updateOrderInfoByMatchResult', 1, 0, 1, '开奖后，修改订单数据');
insert into dl_gate_api_config values(13, '/order/order/updateOrderInfoByPrint', 1, 0, 1, '出票成功，修改订单数据');
insert into dl_gate_api_config values(99, '/order/order/detail/selectIssuesMatchInTodayOrder', 1, 0, 1, '更新订单状态公共方法');

insert into dl_gate_api_config values(14, '/payment/payment/app', 1, 1, 1, 'app支付调用');
insert into dl_gate_api_config values(15, '/payment/payment/query', 1, 1, 1, '支付订单结果 查询');
insert into dl_gate_api_config values(16, '/payment/payment/recharge', 1, 1, 1, 'app充值调用');
insert into dl_gate_api_config values(17, '/payment/payment/withdraw', 1, 1, 1, '提现');
insert into dl_gate_api_config values(18, '/payment/payment/rollbackOrderAmount', 0, 0, 1, '回退订单金额');
insert into dl_gate_api_config values(19, '/payment/payment/withdraw/add', 0, 1, 1, '添加提现进度');
insert into dl_gate_api_config values(20, '/payment/payment/withdraw/list', 1, 1, 1, '提现进度');
insert into dl_gate_api_config values(21, '/payment/payment/wxpay/notify', 0, 0, 0, '回调');

insert into dl_gate_api_config values(22, '/lottery/dl/article/detail', 1, 0, 1, '资讯详情');
insert into dl_gate_api_config values(23, '/lottery/dl/article/list', 1, 0, 1, '资讯首页');
insert into dl_gate_api_config values(24, '/lottery/dl/article/queryArticlesByIds', 1, 0, 1, '前端不用，根据文章id集合查询文章列表');
insert into dl_gate_api_config values(25, '/lottery/dl/article/relatedArticles', 1, 0, 1, '相关文章');
insert into dl_gate_api_config values(26, '/lottery/dl/league/match/asia/list', 1, 0, 1, '亚盘信息');
insert into dl_gate_api_config values(27, '/lottery/dl/league/match/asia/refresh', 0, 0, 1, '亚盘信息刷新');
insert into dl_gate_api_config values(28, '/lottery/dl/league/match/dao/xiao/list', 1, 0, 1, '大小球信息');
insert into dl_gate_api_config values(29, '/lottery/dl/league/match/europe/list', 1, 0, 1, '欧赔信息');
insert into dl_gate_api_config values(30, '/lottery/dl/league/match/europe/refresh', 0, 0, 1, '欧赔刷新 ');
insert into dl_gate_api_config values(31, '/lottery/dl/league/match/result/queryMatchResultByPlayCode', 0, 0, 1, '联赛结果');
insert into dl_gate_api_config values(32, '/lottery/dl/league/match/result/queryMatchResultsByPlayCodes', 0, 0, 1, '联赛结果');
insert into dl_gate_api_config values(33, '/lottery/dl/league/match/result/refresh', 0, 0, 1, '联赛结果刷新');
insert into dl_gate_api_config values(34, '/lottery/dl/league/team/list', 1, 0, 1, '球队信息');
insert into dl_gate_api_config values(35, '/lottery/dl/match/support/refresh', 0, 0, 1, '支持率的刷新');
insert into dl_gate_api_config values(36, '/lottery/lottery/hall/getHallData', 1, 0, 1, '彩票大厅数据');
insert into dl_gate_api_config values(37, '/lottery/lottery/hall/getHallMixData', 1, 0, 1, '获取彩票大厅数据和咨询列表数据');
insert into dl_gate_api_config values(38, '/lottery/lottery/hall/getPlayClassifyList', 1, 0, 1, '获取彩票玩法列表');
insert into dl_gate_api_config values(39, '/lottery/lottery/match/filterConditions', 1, 0, 1, '筛选条件');
insert into dl_gate_api_config values(40, '/lottery/lottery/match/getBetInfo', 1, 0, 1, '投注');
insert into dl_gate_api_config values(41, '/lottery/lottery/match/getBetInfoByOrderSn', 0, 1, 1, '通过订单号读取投注信息');
insert into dl_gate_api_config values(42, '/lottery/lottery/match/getMatchList', 1, 0, 1, '赛事列表');
insert into dl_gate_api_config values(43, '/lottery/lottery/match/matchTeamInfos', 1, 0, 1, '球队分析详情');
insert into dl_gate_api_config values(44, '/lottery/lottery/match/matchTeamInfosSum', 1, 0, 1, '球队分析总结');
insert into dl_gate_api_config values(45, '/lottery/lottery/match/queryMatchResult', 1, 0, 1, '比赛结果');
insert into dl_gate_api_config values(46, '/lottery/lottery/match/saveBetInfo', 1, 1, 1, '保存投注信息');
insert into dl_gate_api_config values(47, '/lottery/lottery/match/saveMatchList', 0, 0, 1, '攫取赛事列表');
insert into dl_gate_api_config values(48, '/lottery/lottery/money/getCountAndMoney', 1, 1, 1, '获取彩票注数及金额');
insert into dl_gate_api_config values(49, '/lottery/lottery/print/callbackStake', 0, 0, 0, '投注结果通知');
insert into dl_gate_api_config values(50, '/lottery/lottery/print/queryAccount', 1, 0, 1, '账户余额查询');
insert into dl_gate_api_config values(51, '/lottery/lottery/print/queryIssue', 1, 0, 1, '其次查询');
insert into dl_gate_api_config values(52, '/lottery/lottery/print/queryPrizeFile', 1, 0, 1, '期次中奖文件查询');
insert into dl_gate_api_config values(53, '/lottery/lottery/print/queryStake', 1, 0, 1, '投注结果查询');
insert into dl_gate_api_config values(54, '/lottery/lottery/print/queryStakeFile', 1, 0, 1, '期次投注对奖文件查询');
insert into dl_gate_api_config values(55, '/lottery/lottery/print/save', 0, 1, 1, '生成预出票信息');
insert into dl_gate_api_config values(56, '/lottery/lottery/print/toStake', 0, 0, 1, '投注接口');
insert into dl_gate_api_config values(57, '/lottery/lottery/reward/queryRewardByIssue', 0, 0, 1, '根据期次，查询审核通过的开奖数据');
insert into dl_gate_api_config values(58, '/lottery/lottery/reward/resolveTxt', 0, 0, 1, '解析中奖文件');
insert into dl_gate_api_config values(59, '/lottery/lottery/reward/saveRewardData', 0, 0, 1, '根据场次id拉取中奖数据');
insert into dl_gate_api_config values(60, '/lottery/lottery/reward/toAwarding', 0, 0, 1, '兑奖接口');


insert into dl_gate_api_config values(61, '/member/user/account/rollbackChangeUserAccountByCreateOrder', 1, 1, 1, '回滚下单时的账户变动：目前仅红包置为未使用');
insert into dl_gate_api_config values(62, '/member/user/account/createUserWithdraw', 1, 1, 1,'用户生成提现单');
insert into dl_gate_api_config values(63, '/member/user/collect/isCollect', 1, 1, 1, '用户收藏列表');
insert into dl_gate_api_config values(64, '/member/user/real/realNameAuth', 1, 1, 1,'实名认证');
insert into dl_gate_api_config values(65, '/member/user/bank/addBankCard', 1, 1, 1,'添加银行卡');
insert into dl_gate_api_config values(66, '/member/user/bank/updateUserBankDefault', 1, 1, 1,'设置银行卡为当前默认');
insert into dl_gate_api_config values(67, '/member/user/account/createReCharege', 1, 1, 1, '用户生成充值单');
insert into dl_gate_api_config values(68, '/member/user/account/rollbackUserAccountChangeByPay', 1, 1, 1, '余额支付或混合支付失败回滚账户的余额');
insert into dl_gate_api_config values(69, '/member/user/real/userRealInfo', 1, 1, 1, '查询实名认证信息');
insert into dl_gate_api_config values(70, '/member/user/bonus/queryValidBonusList', 1, 1, 1, '查询用户有效的红包列表');
insert into dl_gate_api_config values(71, '/member/user/account/getUserAccountList', 1, 1, 1, '查询用户账户明细列表');
insert into dl_gate_api_config values(72, '/member/user/getTokenByMobile', 1, 1, 1, '根据手机号获取tokeninsert into dl_gate_api_config values(60, 不提供调用)');
insert into dl_gate_api_config values(73, '/member/user/userInfoExceptPass', 1, 1, 1, '查询用户信息除了登录密码和支付密码');
insert into dl_gate_api_config values(74, '/member/user/account/countMoneyCurrentMonth', 1, 1, 1, '统计当月的各个用途的资金和');
insert into dl_gate_api_config values(75, '/member/user/account/changeUserAccountByPay', 1, 1, 1, '余额支付引起的账户余额变动');
insert into dl_gate_api_config values(76, '/member/login/loginBySms', 1, 0, 1, '短信验证码登录');
insert into dl_gate_api_config values(77, '/member/user/collect/list', 1, 1, 1, '用户收藏列表');
insert into dl_gate_api_config values(78, '/member/user/bonus/queryBonusListByStatus', 1, 1, 1, '根据状态查询有效的红包集合');
insert into dl_gate_api_config values(79, '/member/user/account/updateReCharege', 1, 1, 1,'更新用户充值单');
insert into dl_gate_api_config values(80, '/member/user/sys/querySysConfig', 1, 0, 1,'根据平台和业务版本查询当前版本是否开启');
insert into dl_gate_api_config values(81, '/member/user/account/updateUserWithdraw', 1, 1, 1, '更新用户提现单');
insert into dl_gate_api_config values(82, '/member/user/collect/delete', 1, 1, 1, '取消收藏');
insert into dl_gate_api_config values(83, '/member/user/bank/deleteUserBank', 1, 1, 1, '删除银行卡');
insert into dl_gate_api_config values(84, '/member/sms/sendSmsCode', 1, 0, 1, '发送短信验证码');
insert into dl_gate_api_config values(85, '/member/user/account/batchUpdateUserAccount', 1, 1, 1, '批量更新用户账户');
insert into dl_gate_api_config values(86, '/member/user/updateLoginPass', 1, 1, 1,'修改用户登录密码');
insert into dl_gate_api_config values(87, '/member/user/account/changeUserAccountByCreateOrder', 1, 1, 1, '下单时的账户变动：目前仅红包置为已使用');
insert into dl_gate_api_config values(88, '/member/user/collect/add', 1, 1, 1, '添加收藏');
insert into dl_gate_api_config values(89, '/member/user/bank/queryUserBank', 1, 1, 1, '查询银行卡');
insert into dl_gate_api_config values(90, '/member/user/message/list', 1, 1, 1, '用户消息列表');
insert into dl_gate_api_config values(91, '/member/user/bonus/queryUserBonus', 1, 1, 1, '根据userBonusId查询单个红包');
insert into dl_gate_api_config values(92, '/member/login/loginByPass', 1, 0, 1, '密码登录');
insert into dl_gate_api_config values(93, '/member/user/bank/queryWithDrawShow', 1, 1, 1, '提现界面的数据显示');
insert into dl_gate_api_config values(94, '/member/user/account/updateUserAccount', 1, 1, 1, '更新用户账户');
insert into dl_gate_api_config values(95, '/member/user/validateMobile', 1, 0, 1, '校验手机号');
insert into dl_gate_api_config values(96, '/member/login/logout', 1, 1, 1, '用户注销');
insert into dl_gate_api_config values(97, '/member/user/bank/queryUserBankList', 1, 1, 1, '查询银行卡列表');
insert into dl_gate_api_config values(98, '/member/user/register', 1, 0, 1, '注册');


insert into dl_gate_api_config values(100, '/member/switch/config/query', 1, 0, 1, '查询交易版开关是否开启');
insert into dl_gate_api_config values(101, '/payment/payment/allPayment', 1, 0, 1, '系统可用第三方支付方式');



insert into dl_gate_api_config values(119, '/member/user/queryUserNotice', 1, 1, 1, '查询用户是否有未读消息提示');
insert into dl_gate_api_config values(120, '/member/user/updateUnReadNotice', 1, 1, 1, '清除未读消息提示');




insert into dl_gate_api_config values(136, '/payment/payment/recharge/queryUserRechargeListByUserId', 1, 1, 1, '查询充值单列表');
insert into dl_gate_api_config values(137, '/payment/payment/recharge/countUserRecharge', 1, 1, 1, '查询当前登录用户是否充值过');
insert into dl_gate_api_config values(138, '/member/user/bonus/rechargeSucReiceiveBonus', 1, 1, 1, '领取充值送随机红包');
insert into dl_gate_api_config values(139, '/payment/payment/queryPayLogByPayLogId', 1, 1, 1, '根据payLogId查询支付信息');
insert into dl_gate_api_config values(140, '/lottery/dl/wc/gjs', 1, 0, 1, '冠军列表');
insert into dl_gate_api_config values(141, '/lottery/dl/wc/gyjs', 1, 0, 1, '冠亚军列表');
insert into dl_gate_api_config values(142, '/lottery/dl/wc/saveBetInfo', 1, 1, 1, '投注');
insert into dl_gate_api_config values(143, '/member/user/setLoginPass', 1, 1, 1, '设置修改密码');
insert into dl_gate_api_config values(144, '/member/donation/rechargeCard/list', 1, 0, 1, '充值卡列表');