# ************************************************************
# Sequel Ace SQL dump
# 版本号： 20050
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: 127.0.0.1 (MySQL 5.6.39)
# 数据库: big_market_01
# 生成时间: 2024-04-30 10:18:45 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE database if NOT EXISTS `big_market_01` default character set utf8mb4;
use `big_market_01`;

# 转储表 raffle_activity_account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_account`;

CREATE TABLE `raffle_activity_account` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `total_count` int(8) NOT NULL COMMENT '总次数',
  `total_count_surplus` int(8) NOT NULL COMMENT '总次数-剩余',
  `day_count` int(8) NOT NULL COMMENT '日次数',
  `day_count_surplus` int(8) NOT NULL COMMENT '日次数-剩余',
  `month_count` int(8) NOT NULL COMMENT '月次数',
  `month_count_surplus` int(8) NOT NULL COMMENT '月次数-剩余',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_id_activity_id` (`user_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动账户表';

LOCK TABLES `raffle_activity_account` WRITE;
/*!40000 ALTER TABLE `raffle_activity_account` DISABLE KEYS */;

INSERT INTO `raffle_activity_account` (`id`, `user_id`, `activity_id`, `total_count`, `total_count_surplus`, `day_count`, `day_count_surplus`, `month_count`, `month_count_surplus`, `create_time`, `update_time`)
VALUES
	(3,'xiaofuge',100301,10000,10000,10000,10000,10000,10000,'2024-03-23 16:38:57','2024-04-27 15:49:56');

/*!40000 ALTER TABLE `raffle_activity_account` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 raffle_activity_account_day
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_account_day`;

CREATE TABLE `raffle_activity_account_day` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `day` varchar(10) NOT NULL COMMENT '日期（yyyy-mm-dd）',
  `day_count` int(8) NOT NULL COMMENT '日次数',
  `day_count_surplus` int(8) NOT NULL COMMENT '日次数-剩余',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_id_activity_id_day` (`user_id`,`activity_id`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动账户表-日次数';

LOCK TABLES `raffle_activity_account_day` WRITE;
/*!40000 ALTER TABLE `raffle_activity_account_day` DISABLE KEYS */;

INSERT INTO `raffle_activity_account_day` (`id`, `user_id`, `activity_id`, `day`, `day_count`, `day_count_surplus`, `create_time`, `update_time`)
VALUES
	(2,'xiaofuge',100301,'2024-04-05',45,44,'2024-04-05 17:10:31','2024-04-05 17:10:31'),
	(3,'xiaofuge',100301,'2024-04-08',45,44,'2024-04-08 22:52:47','2024-04-08 22:52:47'),
	(4,'xiaofuge',100301,'2024-04-13',45,23,'2024-04-13 11:44:10','2024-04-20 10:51:09'),
	(7,'xiaofuge',100301,'2024-04-20',45,13,'2024-04-20 16:50:38','2024-04-20 16:50:38');

/*!40000 ALTER TABLE `raffle_activity_account_day` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 raffle_activity_account_month
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_account_month`;

CREATE TABLE `raffle_activity_account_month` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `month` varchar(7) NOT NULL COMMENT '月（yyyy-mm）',
  `month_count` int(8) NOT NULL COMMENT '月次数',
  `month_count_surplus` int(8) NOT NULL COMMENT '月次数-剩余',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_id_activity_id_month` (`user_id`,`activity_id`,`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动账户表-月次数';



# 转储表 raffle_activity_order_000
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_000`;

CREATE TABLE `raffle_activity_order_000` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint(12) NOT NULL COMMENT '商品sku',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int(8) NOT NULL COMMENT '总次数',
  `day_count` int(8) NOT NULL COMMENT '日次数',
  `month_count` int(8) NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';



# 转储表 raffle_activity_order_001
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_001`;

CREATE TABLE `raffle_activity_order_001` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint(12) NOT NULL COMMENT '商品sku',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int(8) NOT NULL COMMENT '总次数',
  `day_count` int(8) NOT NULL COMMENT '日次数',
  `month_count` int(8) NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';

LOCK TABLES `raffle_activity_order_001` WRITE;
/*!40000 ALTER TABLE `raffle_activity_order_001` DISABLE KEYS */;

INSERT INTO `raffle_activity_order_001` (`id`, `user_id`, `sku`, `activity_id`, `activity_name`, `strategy_id`, `order_id`, `order_time`, `total_count`, `day_count`, `month_count`, `state`, `out_business_no`, `create_time`, `update_time`)
VALUES
	(71,'xiaofuge',9011,100301,'测试活动',100006,'761345538871','2024-04-21 10:40:25',1,1,1,'completed','073735003829','2024-04-21 18:40:25','2024-04-21 18:40:25'),
	(72,'xiaofuge',9011,100301,'测试活动',100006,'837744050164','2024-04-21 10:40:25',1,1,1,'completed','613036507854','2024-04-21 18:40:25','2024-04-21 18:40:25'),
	(73,'xiaofuge',9011,100301,'测试活动',100006,'766742523760','2024-04-21 10:40:25',1,1,1,'completed','649099837249','2024-04-21 18:40:25','2024-04-21 18:40:25'),
	(74,'xiaofuge',9011,100301,'测试活动',100006,'856474163547','2024-04-21 10:40:25',1,1,1,'completed','652903372986','2024-04-21 18:40:25','2024-04-21 18:40:25'),
	(75,'xiaofuge',9011,100301,'测试活动',100006,'668775949799','2024-04-21 10:40:25',1,1,1,'completed','097066347980','2024-04-21 18:40:25','2024-04-21 18:40:25');

/*!40000 ALTER TABLE `raffle_activity_order_001` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 raffle_activity_order_002
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_002`;

CREATE TABLE `raffle_activity_order_002` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint(12) NOT NULL COMMENT '商品sku',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int(8) NOT NULL COMMENT '总次数',
  `day_count` int(8) NOT NULL COMMENT '日次数',
  `month_count` int(8) NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';



# 转储表 raffle_activity_order_003
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_003`;

CREATE TABLE `raffle_activity_order_003` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint(12) NOT NULL COMMENT '商品sku',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int(8) NOT NULL COMMENT '总次数',
  `day_count` int(8) NOT NULL COMMENT '日次数',
  `month_count` int(8) NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';



# 转储表 task
# ------------------------------------------------------------

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `topic` varchar(32) NOT NULL COMMENT '消息主题',
  `message_id` varchar(11) DEFAULT NULL COMMENT '消息编号',
  `message` varchar(512) NOT NULL COMMENT '消息主体',
  `state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '任务状态；create-创建、completed-完成、fail-失败',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_message_id` (`message_id`),
  KEY `idx_state` (`state`),
  KEY `idx_create_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务表，发送MQ';

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;

INSERT INTO `task` (`id`, `user_id`, `topic`, `message_id`, `message`, `state`, `create_time`, `update_time`)
VALUES
	(1,'xiaofuge','send_award','23913710462','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"23913710462\",\"timestamp\":1712374909975}','completed','2024-04-06 11:41:50','2024-04-06 12:14:50'),
	(2,'xiaofuge','send_award','33004806135','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"33004806135\",\"timestamp\":1712375273609}','completed','2024-04-06 11:47:54','2024-04-06 12:14:50'),
	(3,'xiaofuge','send_award','61315401992','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"61315401992\",\"timestamp\":1712377009778}','completed','2024-04-06 12:16:50','2024-04-06 12:16:50'),
	(4,'xiaofuge','send_award','74920280321','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"74920280321\",\"timestamp\":1712377010878}','completed','2024-04-06 12:16:50','2024-04-06 12:16:50'),
	(5,'xiaofuge','send_award','71692388884','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"71692388884\",\"timestamp\":1712377011390}','completed','2024-04-06 12:16:51','2024-04-06 12:16:51'),
	(6,'xiaofuge','send_award','11524874230','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"11524874230\",\"timestamp\":1712377011913}','completed','2024-04-06 12:16:51','2024-04-06 12:16:51'),
	(7,'xiaofuge','send_award','39972412889','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"39972412889\",\"timestamp\":1712377012434}','completed','2024-04-06 12:16:52','2024-04-06 12:16:52'),
	(8,'xiaofuge','send_award','79019640497','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"79019640497\",\"timestamp\":1712377012955}','completed','2024-04-06 12:16:52','2024-04-06 12:16:52'),
	(9,'xiaofuge','send_award','97077031398','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"97077031398\",\"timestamp\":1712377013498}','completed','2024-04-06 12:16:53','2024-04-06 12:16:53'),
	(10,'xiaofuge','send_award','08720582836','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"08720582836\",\"timestamp\":1712377014017}','completed','2024-04-06 12:16:54','2024-04-06 12:16:54'),
	(11,'xiaofuge','send_award','60787815183','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"60787815183\",\"timestamp\":1712377014529}','completed','2024-04-06 12:16:54','2024-04-06 12:16:54'),
	(12,'xiaofuge','send_award','97145040946','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"97145040946\",\"timestamp\":1712377015040}','completed','2024-04-06 12:16:55','2024-04-06 12:16:55'),
	(13,'xiaofuge','send_award','40165031868','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"40165031868\",\"timestamp\":1712377015553}','completed','2024-04-06 12:16:55','2024-04-06 12:16:55'),
	(14,'xiaofuge','send_award','31142176572','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"31142176572\",\"timestamp\":1712377016066}','completed','2024-04-06 12:16:56','2024-04-06 12:16:56'),
	(15,'xiaofuge','send_award','54723488249','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"54723488249\",\"timestamp\":1712377016577}','completed','2024-04-06 12:16:56','2024-04-06 12:16:56'),
	(16,'xiaofuge','send_award','94553316274','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"94553316274\",\"timestamp\":1712377017090}','completed','2024-04-06 12:16:57','2024-04-06 16:07:00'),
	(17,'xiaofuge','send_award','47638237311','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"47638237311\",\"timestamp\":1712377017601}','completed','2024-04-06 12:16:57','2024-04-06 16:07:00'),
	(18,'xiaofuge','send_award','08472548108','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"08472548108\",\"timestamp\":1712377018112}','completed','2024-04-06 12:16:58','2024-04-06 16:07:00'),
	(19,'xiaofuge','send_award','01704262897','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"01704262897\",\"timestamp\":1712391038041}','completed','2024-04-06 16:10:38','2024-04-06 16:10:38'),
	(20,'xiaofuge','send_award','96818112357','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"96818112357\",\"timestamp\":1712391039234}','completed','2024-04-06 16:10:39','2024-04-06 16:10:39'),
	(21,'xiaofuge','send_award','39815817631','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"39815817631\",\"timestamp\":1712391039751}','completed','2024-04-06 16:10:39','2024-04-06 16:10:39'),
	(22,'xiaofuge','send_award','44228382875','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"44228382875\",\"timestamp\":1712391040268}','completed','2024-04-06 16:10:40','2024-04-06 16:10:40'),
	(23,'xiaofuge','send_award','61240314870','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"61240314870\",\"timestamp\":1712391040784}','completed','2024-04-06 16:10:40','2024-04-06 16:10:40'),
	(24,'xiaofuge','send_award','30911821347','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"30911821347\",\"timestamp\":1712391041333}','completed','2024-04-06 16:10:41','2024-04-06 16:10:41'),
	(25,'xiaofuge','send_award','41575602711','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"41575602711\",\"timestamp\":1712391041849}','completed','2024-04-06 16:10:41','2024-04-06 16:10:41'),
	(26,'xiaofuge','send_award','72379603310','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"72379603310\",\"timestamp\":1712391042361}','completed','2024-04-06 16:10:42','2024-04-06 16:10:42'),
	(27,'xiaofuge','send_award','51671684313','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"51671684313\",\"timestamp\":1712391042875}','completed','2024-04-06 16:10:42','2024-04-06 16:10:42'),
	(28,'xiaofuge','send_award','11840468669','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"11840468669\",\"timestamp\":1712391043390}','completed','2024-04-06 16:10:43','2024-04-06 16:10:43'),
	(29,'xiaofuge','send_award','18467905170','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"18467905170\",\"timestamp\":1712391043908}','completed','2024-04-06 16:10:43','2024-04-06 16:10:43'),
	(30,'xiaofuge','send_award','33233781451','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"33233781451\",\"timestamp\":1712391044424}','completed','2024-04-06 16:10:44','2024-04-06 16:10:44'),
	(31,'xiaofuge','send_award','09679212052','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"09679212052\",\"timestamp\":1712391044938}','completed','2024-04-06 16:10:44','2024-04-06 16:10:44'),
	(32,'xiaofuge','send_award','96862889309','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"96862889309\",\"timestamp\":1712391045450}','completed','2024-04-06 16:10:45','2024-04-06 16:10:45'),
	(33,'xiaofuge','send_award','69912628282','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"69912628282\",\"timestamp\":1712391045962}','completed','2024-04-06 16:10:45','2024-04-06 16:10:45'),
	(34,'xiaofuge','send_award','26021447219','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"26021447219\",\"timestamp\":1712391046477}','completed','2024-04-06 16:10:46','2024-04-13 10:48:45'),
	(35,'xiaofuge','send_award','29510804265','{\"data\":{\"awardId\":101,\"awardTitle\":\"OpenAI 增加使用次数\",\"userId\":\"xiaofuge\"},\"id\":\"29510804265\",\"timestamp\":1712391047005}','completed','2024-04-06 16:10:47','2024-04-13 10:48:45'),
	(36,'xiaofuge','send_award','99669876677','{\"data\":{\"awardId\":107,\"awardTitle\":\"2等奖\",\"userId\":\"xiaofuge\"},\"id\":\"99669876677\",\"timestamp\":1712979841591}','completed','2024-04-13 11:44:01','2024-04-13 11:44:01'),
	(37,'xiaofuge','send_award','13183725005','{\"data\":{\"awardId\":103,\"awardTitle\":\"6等奖\",\"userId\":\"xiaofuge\"},\"id\":\"13183725005\",\"timestamp\":1712979850853}','completed','2024-04-13 11:44:10','2024-04-13 11:44:10'),
	(38,'xiaofuge','send_award','13436201468','{\"data\":{\"awardId\":101,\"awardTitle\":\"随机积分\",\"userId\":\"xiaofuge\"},\"id\":\"13436201468\",\"timestamp\":1712979854073}','completed','2024-04-13 11:44:14','2024-04-13 11:44:14'),
	(39,'xiaofuge','send_award','89567645271','{\"data\":{\"awardId\":106,\"awardTitle\":\"3等奖\",\"userId\":\"xiaofuge\"},\"id\":\"89567645271\",\"timestamp\":1712979855601}','completed','2024-04-13 11:44:15','2024-04-13 11:44:15'),
	(40,'xiaofuge','send_award','00308200403','{\"data\":{\"awardId\":106,\"awardTitle\":\"3等奖\",\"userId\":\"xiaofuge\"},\"id\":\"00308200403\",\"timestamp\":1712979856602}','completed','2024-04-13 11:44:16','2024-04-13 11:44:16'),
	(41,'xiaofuge','send_award','70460061560','{\"data\":{\"awardId\":104,\"awardTitle\":\"5等奖\",\"userId\":\"xiaofuge\"},\"id\":\"70460061560\",\"timestamp\":1712979857586}','completed','2024-04-13 11:44:17','2024-04-13 11:44:17'),
	(42,'xiaofuge','send_award','03493035635','{\"data\":{\"awardId\":102,\"awardTitle\":\"7等奖\",\"userId\":\"xiaofuge\"},\"id\":\"03493035635\",\"timestamp\":1712979858714}','completed','2024-04-13 11:44:18','2024-04-13 11:44:18'),
	(43,'xiaofuge','send_award','22062172114','{\"data\":{\"awardId\":103,\"awardTitle\":\"6等奖\",\"userId\":\"xiaofuge\"},\"id\":\"22062172114\",\"timestamp\":1712979929672}','completed','2024-04-13 11:45:29','2024-04-13 11:45:29'),
	(44,'xiaofuge','send_award','75973092346','{\"data\":{\"awardId\":102,\"awardTitle\":\"7等奖\",\"userId\":\"xiaofuge\"},\"id\":\"75973092346\",\"timestamp\":1712979930723}','completed','2024-04-13 11:45:30','2024-04-13 11:45:30'),
	(45,'xiaofuge','send_award','32769685487','{\"data\":{\"awardId\":102,\"awardTitle\":\"7等奖\",\"userId\":\"xiaofuge\"},\"id\":\"32769685487\",\"timestamp\":1712981693149}','completed','2024-04-13 12:14:53','2024-04-13 12:14:53'),
	(46,'xiaofuge','send_award','85144595338','{\"data\":{\"awardId\":104,\"awardTitle\":\"5等奖\",\"userId\":\"xiaofuge\"},\"id\":\"85144595338\",\"timestamp\":1712981853669}','completed','2024-04-13 12:17:33','2024-04-13 12:17:33'),
	(47,'xiaofuge','send_award','44874364790','{\"data\":{\"awardId\":103,\"awardTitle\":\"6等奖\",\"userId\":\"xiaofuge\"},\"id\":\"44874364790\",\"timestamp\":1712981896942}','completed','2024-04-13 12:18:16','2024-04-13 12:18:16'),
	(48,'xiaofuge','send_award','85399883630','{\"data\":{\"awardId\":103,\"awardTitle\":\"6等奖\",\"userId\":\"xiaofuge\"},\"id\":\"85399883630\",\"timestamp\":1712981903339}','completed','2024-04-13 12:18:23','2024-04-13 12:18:23'),
	(49,'xiaofuge','send_award','29729581514','{\"data\":{\"awardId\":104,\"awardTitle\":\"5等奖\",\"userId\":\"xiaofuge\"},\"id\":\"29729581514\",\"timestamp\":1712981904841}','completed','2024-04-13 12:18:24','2024-04-13 12:18:24'),
	(50,'xiaofuge','send_award','74718298956','{\"data\":{\"awardId\":105,\"awardTitle\":\"4等奖\",\"userId\":\"xiaofuge\"},\"id\":\"74718298956\",\"timestamp\":1712981905797}','completed','2024-04-13 12:18:25','2024-04-13 12:18:25'),
	(51,'xiaofuge','send_award','50114477022','{\"data\":{\"awardId\":107,\"awardTitle\":\"2等奖\",\"userId\":\"xiaofuge\"},\"id\":\"50114477022\",\"timestamp\":1712981916880}','completed','2024-04-13 12:18:36','2024-04-13 12:18:36'),
	(52,'xiaofuge','send_award','28956245329','{\"data\":{\"awardId\":102,\"awardTitle\":\"7等奖\",\"userId\":\"xiaofuge\"},\"id\":\"28956245329\",\"timestamp\":1712982007542}','completed','2024-04-13 12:20:07','2024-04-13 12:20:07'),
	(53,'xiaofuge','send_award','99592907656','{\"data\":{\"awardId\":104,\"awardTitle\":\"5等奖\",\"userId\":\"xiaofuge\"},\"id\":\"99592907656\",\"timestamp\":1712982009729}','completed','2024-04-13 12:20:09','2024-04-13 12:20:09'),
	(54,'xiaofuge','send_award','19525539782','{\"data\":{\"awardId\":104,\"awardTitle\":\"5等奖\",\"userId\":\"xiaofuge\"},\"id\":\"19525539782\",\"timestamp\":1712982013711}','completed','2024-04-13 12:20:13','2024-04-13 12:20:13'),
	(55,'xiaofuge','send_award','47878047199','{\"data\":{\"awardId\":105,\"awardTitle\":\"4等奖\",\"userId\":\"xiaofuge\"},\"id\":\"47878047199\",\"timestamp\":1712982014913}','completed','2024-04-13 12:20:14','2024-04-13 12:20:14'),
	(56,'xiaofuge','send_award','27264311844','{\"data\":{\"awardId\":102,\"awardTitle\":\"7等奖\",\"userId\":\"xiaofuge\"},\"id\":\"27264311844\",\"timestamp\":1712982016134}','completed','2024-04-13 12:20:16','2024-04-13 12:20:16'),
	(57,'xiaofuge','send_award','77749836320','{\"data\":{\"awardId\":106,\"awardTitle\":\"3等奖\",\"userId\":\"xiaofuge\"},\"id\":\"77749836320\",\"timestamp\":1712982020673}','completed','2024-04-13 12:20:20','2024-04-13 12:20:20'),
	(58,'xiaofuge','send_award','47587820823','{\"data\":{\"awardId\":102,\"awardTitle\":\"7等奖\",\"userId\":\"xiaofuge\"},\"id\":\"47587820823\",\"timestamp\":1712988239372}','completed','2024-04-13 14:03:59','2024-04-13 14:03:59'),
	(59,'xiaofuge','send_award','58931754976','{\"data\":{\"awardId\":104,\"awardTitle\":\"5等奖\",\"userId\":\"xiaofuge\"},\"id\":\"58931754976\",\"timestamp\":1712993105696}','completed','2024-04-13 15:25:06','2024-04-13 15:25:06'),
	(60,'xiaofuge','send_award','67608143436','{\"data\":{\"awardId\":102,\"awardTitle\":\"7等奖\",\"userId\":\"xiaofuge\"},\"id\":\"67608143436\",\"timestamp\":1712993111209}','completed','2024-04-13 15:25:11','2024-04-13 15:25:11'),
	(61,'xiaofuge','send_award','22711974997','{\"data\":{\"awardId\":101,\"awardTitle\":\"随机积分\",\"userId\":\"xiaofuge\"},\"id\":\"22711974997\",\"timestamp\":1712993112288}','completed','2024-04-13 15:25:12','2024-04-13 15:25:12'),
	(62,'xiaofuge','send_award','39728508373','{\"data\":{\"awardId\":107,\"awardTitle\":\"2等奖\",\"userId\":\"xiaofuge\"},\"id\":\"39728508373\",\"timestamp\":1712993121051}','completed','2024-04-13 15:25:21','2024-04-13 15:25:21'),
	(63,'xiaofuge','send_award','29346013696','{\"data\":{\"awardId\":105,\"awardTitle\":\"4等奖\",\"userId\":\"xiaofuge\"},\"id\":\"29346013696\",\"timestamp\":1713586170567}','completed','2024-04-20 12:09:30','2024-04-20 12:09:30'),
	(64,'xiaofuge','send_award','26345538109','{\"data\":{\"awardId\":106,\"awardTitle\":\"3等奖\",\"userId\":\"xiaofuge\"},\"id\":\"26345538109\",\"timestamp\":1713586284216}','completed','2024-04-20 12:11:24','2024-04-20 12:11:24'),
	(65,'xiaofuge','send_award','08631161692','{\"data\":{\"awardId\":105,\"awardTitle\":\"4等奖\",\"userId\":\"xiaofuge\"},\"id\":\"08631161692\",\"timestamp\":1713597058001}','completed','2024-04-20 15:10:58','2024-04-20 15:10:58'),
	(66,'xiaofuge','send_award','39622786502','{\"data\":{\"awardId\":107,\"awardTitle\":\"2等奖\",\"userId\":\"xiaofuge\"},\"id\":\"39622786502\",\"timestamp\":1713598992837}','completed','2024-04-20 15:43:13','2024-04-20 15:43:13'),
	(67,'xiaofuge','send_award','66657753896','{\"data\":{\"awardId\":106,\"awardTitle\":\"3等奖\",\"userId\":\"xiaofuge\"},\"id\":\"66657753896\",\"timestamp\":1713603038553}','completed','2024-04-20 16:50:39','2024-04-20 16:50:39'),
	(68,'xiaofuge','send_award','87700384224','{\"data\":{\"awardId\":108,\"awardTitle\":\"暴走玩偶\",\"userId\":\"xiaofuge\"},\"id\":\"87700384224\",\"timestamp\":1714195178827}','completed','2024-04-27 13:19:38','2024-04-27 13:19:38'),
	(69,'xiaofuge','send_award','34246976218','{\"data\":{\"awardId\":101,\"awardTitle\":\"随机积分\",\"userId\":\"xiaofuge\"},\"id\":\"34246976218\",\"timestamp\":1714195637200}','completed','2024-04-27 13:27:17','2024-04-27 13:27:17'),
	(70,'xiaofuge','send_award','67418825974','{\"data\":{\"awardId\":104,\"awardTitle\":\"小米台灯\",\"userId\":\"xiaofuge\"},\"id\":\"67418825974\",\"timestamp\":1714195665080}','completed','2024-04-27 13:27:45','2024-04-27 13:27:45'),
	(71,'xiaofuge','send_award','28182567445','{\"data\":{\"awardId\":102,\"awardTitle\":\"OpenAI会员卡\",\"userId\":\"xiaofuge\"},\"id\":\"28182567445\",\"timestamp\":1714195681839}','completed','2024-04-27 13:28:01','2024-04-27 13:28:01'),
	(72,'xiaofuge','send_award','43921644960','{\"data\":{\"awardId\":106,\"awardTitle\":\"轻奢办公椅\",\"userId\":\"xiaofuge\"},\"id\":\"43921644960\",\"timestamp\":1714195745254}','completed','2024-04-27 13:29:05','2024-04-27 13:29:05'),
	(73,'xiaofuge','send_award','83192193690','{\"data\":{\"awardId\":103,\"awardTitle\":\"支付优惠券\",\"userId\":\"xiaofuge\"},\"id\":\"83192193690\",\"timestamp\":1714195771714}','completed','2024-04-27 13:29:31','2024-04-27 13:29:31'),
	(74,'xiaofuge','send_award','71879339129','{\"data\":{\"awardId\":106,\"awardTitle\":\"轻奢办公椅\",\"userId\":\"xiaofuge\"},\"id\":\"71879339129\",\"timestamp\":1714195797449}','completed','2024-04-27 13:29:57','2024-04-27 13:29:57'),
	(75,'xiaofuge','send_award','82583508840','{\"data\":{\"awardId\":107,\"awardTitle\":\"小霸王游戏机\",\"userId\":\"xiaofuge\"},\"id\":\"82583508840\",\"timestamp\":1714195811069}','completed','2024-04-27 13:30:11','2024-04-27 13:30:11'),
	(76,'xiaofuge','send_award','21336975617','{\"data\":{\"awardId\":107,\"awardTitle\":\"小霸王游戏机\",\"userId\":\"xiaofuge\"},\"id\":\"21336975617\",\"timestamp\":1714196187285}','completed','2024-04-27 13:36:27','2024-04-27 13:36:27'),
	(77,'xiaofuge','send_award','54277155930','{\"data\":{\"awardId\":101,\"awardTitle\":\"随机积分\",\"userId\":\"xiaofuge\"},\"id\":\"54277155930\",\"timestamp\":1714196280178}','completed','2024-04-27 13:38:00','2024-04-27 13:38:00'),
	(78,'xiaofuge','send_award','90789466751','{\"data\":{\"awardId\":104,\"awardTitle\":\"小米台灯\",\"userId\":\"xiaofuge\"},\"id\":\"90789466751\",\"timestamp\":1714196335804}','completed','2024-04-27 13:38:55','2024-04-27 13:38:55'),
	(79,'xiaofuge','send_award','62146713103','{\"data\":{\"awardId\":101,\"awardTitle\":\"随机积分\",\"userId\":\"xiaofuge\"},\"id\":\"62146713103\",\"timestamp\":1714196358336}','completed','2024-04-27 13:39:18','2024-04-27 13:39:18'),
	(80,'xiaofuge','send_award','69804673669','{\"data\":{\"awardId\":101,\"awardTitle\":\"随机积分\",\"userId\":\"xiaofuge\"},\"id\":\"69804673669\",\"timestamp\":1714201196264}','completed','2024-04-27 14:59:56','2024-04-27 14:59:56'),
	(81,'xiaofuge','send_award','56789986275','{\"data\":{\"awardId\":102,\"awardTitle\":\"OpenAI会员卡\",\"userId\":\"xiaofuge\"},\"id\":\"56789986275\",\"timestamp\":1714201214179}','completed','2024-04-27 15:00:14','2024-04-27 15:00:14'),
	(82,'xiaofuge','send_award','05612212348','{\"data\":{\"awardId\":104,\"awardTitle\":\"小米台灯\",\"userId\":\"xiaofuge\"},\"id\":\"05612212348\",\"timestamp\":1714201222825}','completed','2024-04-27 15:00:22','2024-04-27 15:00:22'),
	(83,'xiaofuge','send_rebate','35170430024','{\"data\":{\"bizId\":\"xiaofuge_sku_20240430\",\"rebateConfig\":\"9011\",\"rebateType\":\"sign\",\"userId\":\"xiaofuge\"},\"id\":\"35170430024\",\"timestamp\":1714471292871}','completed','2024-04-30 18:01:33','2024-04-30 18:01:33'),
	(84,'xiaofuge','send_rebate','33541289034','{\"data\":{\"bizId\":\"xiaofuge_sku_20240430\",\"rebateConfig\":\"9011\",\"rebateType\":\"sign\",\"userId\":\"xiaofuge\"},\"id\":\"33541289034\",\"timestamp\":1714471544134}','completed','2024-04-30 18:05:44','2024-04-30 18:05:44'),
	(85,'xiaofuge','send_rebate','42019106000','{\"data\":{\"bizId\":\"xiaofuge_integral_20240430\",\"rebateConfig\":\"10\",\"rebateType\":\"sign\",\"userId\":\"xiaofuge\"},\"id\":\"42019106000\",\"timestamp\":1714471544137}','completed','2024-04-30 18:05:44','2024-04-30 18:05:44');

/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user_award_record_000
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_award_record_000`;

CREATE TABLE `user_award_record_000` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int(11) NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_activity_id` (`activity_id`),
  KEY `idx_award_id` (`strategy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户中奖记录表';



# 转储表 user_award_record_001
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_award_record_001`;

CREATE TABLE `user_award_record_001` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int(11) NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_activity_id` (`activity_id`),
  KEY `idx_award_id` (`strategy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户中奖记录表';

LOCK TABLES `user_award_record_001` WRITE;
/*!40000 ALTER TABLE `user_award_record_001` DISABLE KEYS */;

INSERT INTO `user_award_record_001` (`id`, `user_id`, `activity_id`, `strategy_id`, `order_id`, `award_id`, `award_title`, `award_time`, `award_state`, `create_time`, `update_time`)
VALUES
	(1,'xiaofuge',100301,100006,'313091076458',101,'OpenAI 增加使用次数','2024-04-06 03:41:50','create','2024-04-06 11:41:50','2024-04-06 11:41:50'),
	(3,'xiaofuge',100301,100006,'313091076459',101,'OpenAI 增加使用次数','2024-04-06 03:47:54','create','2024-04-06 11:47:54','2024-04-06 11:47:54'),
	(6,'xiaofuge',100301,100006,'658772889112',101,'OpenAI 增加使用次数','2024-04-06 04:16:50','create','2024-04-06 12:16:50','2024-04-06 12:16:50'),
	(7,'xiaofuge',100301,100006,'623291703218',101,'OpenAI 增加使用次数','2024-04-06 04:16:51','create','2024-04-06 12:16:50','2024-04-06 12:16:50'),
	(8,'xiaofuge',100301,100006,'619841045154',101,'OpenAI 增加使用次数','2024-04-06 04:16:51','create','2024-04-06 12:16:51','2024-04-06 12:16:51'),
	(9,'xiaofuge',100301,100006,'696947604604',101,'OpenAI 增加使用次数','2024-04-06 04:16:52','create','2024-04-06 12:16:51','2024-04-06 12:16:51'),
	(10,'xiaofuge',100301,100006,'239997053403',101,'OpenAI 增加使用次数','2024-04-06 04:16:52','create','2024-04-06 12:16:52','2024-04-06 12:16:52'),
	(11,'xiaofuge',100301,100006,'837228766840',101,'OpenAI 增加使用次数','2024-04-06 04:16:53','create','2024-04-06 12:16:52','2024-04-06 12:16:52'),
	(12,'xiaofuge',100301,100006,'012609968231',101,'OpenAI 增加使用次数','2024-04-06 04:16:53','create','2024-04-06 12:16:53','2024-04-06 12:16:53'),
	(13,'xiaofuge',100301,100006,'540056227059',101,'OpenAI 增加使用次数','2024-04-06 04:16:54','create','2024-04-06 12:16:54','2024-04-06 12:16:54'),
	(14,'xiaofuge',100301,100006,'757384073568',101,'OpenAI 增加使用次数','2024-04-06 04:16:55','create','2024-04-06 12:16:54','2024-04-06 12:16:54'),
	(15,'xiaofuge',100301,100006,'270533634609',101,'OpenAI 增加使用次数','2024-04-06 04:16:55','create','2024-04-06 12:16:55','2024-04-06 12:16:55'),
	(16,'xiaofuge',100301,100006,'143517041178',101,'OpenAI 增加使用次数','2024-04-06 04:16:56','create','2024-04-06 12:16:55','2024-04-06 12:16:55'),
	(17,'xiaofuge',100301,100006,'880610933571',101,'OpenAI 增加使用次数','2024-04-06 04:16:56','create','2024-04-06 12:16:56','2024-04-06 12:16:56'),
	(18,'xiaofuge',100301,100006,'288939138548',101,'OpenAI 增加使用次数','2024-04-06 04:16:57','create','2024-04-06 12:16:56','2024-04-06 12:16:56'),
	(19,'xiaofuge',100301,100006,'401825045013',101,'OpenAI 增加使用次数','2024-04-06 04:16:57','create','2024-04-06 12:16:57','2024-04-06 12:16:57'),
	(20,'xiaofuge',100301,100006,'644483213191',101,'OpenAI 增加使用次数','2024-04-06 04:16:58','create','2024-04-06 12:16:57','2024-04-06 12:16:57'),
	(21,'xiaofuge',100301,100006,'126942948062',101,'OpenAI 增加使用次数','2024-04-06 04:16:58','create','2024-04-06 12:16:58','2024-04-06 12:16:58'),
	(22,'xiaofuge',100301,100006,'388415276639',101,'OpenAI 增加使用次数','2024-04-06 08:10:38','create','2024-04-06 16:10:38','2024-04-06 16:10:38'),
	(23,'xiaofuge',100301,100006,'295404830039',101,'OpenAI 增加使用次数','2024-04-06 08:10:39','create','2024-04-06 16:10:39','2024-04-06 16:10:39'),
	(24,'xiaofuge',100301,100006,'396378174546',101,'OpenAI 增加使用次数','2024-04-06 08:10:40','create','2024-04-06 16:10:39','2024-04-06 16:10:39'),
	(25,'xiaofuge',100301,100006,'216034880115',101,'OpenAI 增加使用次数','2024-04-06 08:10:40','create','2024-04-06 16:10:40','2024-04-06 16:10:40'),
	(26,'xiaofuge',100301,100006,'587083012812',101,'OpenAI 增加使用次数','2024-04-06 08:10:41','create','2024-04-06 16:10:40','2024-04-06 16:10:40'),
	(27,'xiaofuge',100301,100006,'179931564604',101,'OpenAI 增加使用次数','2024-04-06 08:10:41','create','2024-04-06 16:10:41','2024-04-06 16:10:41'),
	(28,'xiaofuge',100301,100006,'266603270575',101,'OpenAI 增加使用次数','2024-04-06 08:10:42','create','2024-04-06 16:10:41','2024-04-06 16:10:41'),
	(29,'xiaofuge',100301,100006,'708306230375',101,'OpenAI 增加使用次数','2024-04-06 08:10:42','create','2024-04-06 16:10:42','2024-04-06 16:10:42'),
	(30,'xiaofuge',100301,100006,'099363576226',101,'OpenAI 增加使用次数','2024-04-06 08:10:43','create','2024-04-06 16:10:42','2024-04-06 16:10:42'),
	(31,'xiaofuge',100301,100006,'330354920093',101,'OpenAI 增加使用次数','2024-04-06 08:10:43','create','2024-04-06 16:10:43','2024-04-06 16:10:43'),
	(32,'xiaofuge',100301,100006,'824752758415',101,'OpenAI 增加使用次数','2024-04-06 08:10:44','create','2024-04-06 16:10:43','2024-04-06 16:10:43'),
	(33,'xiaofuge',100301,100006,'064058506146',101,'OpenAI 增加使用次数','2024-04-06 08:10:44','create','2024-04-06 16:10:44','2024-04-06 16:10:44'),
	(34,'xiaofuge',100301,100006,'923475474250',101,'OpenAI 增加使用次数','2024-04-06 08:10:45','create','2024-04-06 16:10:44','2024-04-06 16:10:44'),
	(35,'xiaofuge',100301,100006,'565064446034',101,'OpenAI 增加使用次数','2024-04-06 08:10:45','create','2024-04-06 16:10:45','2024-04-06 16:10:45'),
	(36,'xiaofuge',100301,100006,'665449773785',101,'OpenAI 增加使用次数','2024-04-06 08:10:46','create','2024-04-06 16:10:45','2024-04-06 16:10:45'),
	(37,'xiaofuge',100301,100006,'099294776536',101,'OpenAI 增加使用次数','2024-04-06 08:10:46','create','2024-04-06 16:10:46','2024-04-06 16:10:46'),
	(38,'xiaofuge',100301,100006,'166766849249',101,'OpenAI 增加使用次数','2024-04-06 08:10:47','create','2024-04-06 16:10:47','2024-04-06 16:10:47'),
	(39,'xiaofuge',100301,100006,'569856975978',107,'2等奖','2024-04-13 03:44:02','create','2024-04-13 11:44:01','2024-04-13 11:44:01'),
	(40,'xiaofuge',100301,100006,'867136698684',103,'6等奖','2024-04-13 03:44:11','create','2024-04-13 11:44:10','2024-04-13 11:44:10'),
	(41,'xiaofuge',100301,100006,'250425115608',101,'随机积分','2024-04-13 03:44:14','create','2024-04-13 11:44:14','2024-04-13 11:44:14'),
	(42,'xiaofuge',100301,100006,'663910993767',106,'3等奖','2024-04-13 03:44:16','create','2024-04-13 11:44:15','2024-04-13 11:44:15'),
	(43,'xiaofuge',100301,100006,'218374542905',106,'3等奖','2024-04-13 03:44:17','create','2024-04-13 11:44:16','2024-04-13 11:44:16'),
	(44,'xiaofuge',100301,100006,'225714694474',104,'5等奖','2024-04-13 03:44:18','create','2024-04-13 11:44:17','2024-04-13 11:44:17'),
	(45,'xiaofuge',100301,100006,'431167372778',102,'7等奖','2024-04-13 03:44:19','create','2024-04-13 11:44:18','2024-04-13 11:44:18'),
	(46,'xiaofuge',100301,100006,'434079846497',103,'6等奖','2024-04-13 03:45:30','create','2024-04-13 11:45:29','2024-04-13 11:45:29'),
	(47,'xiaofuge',100301,100006,'965685676429',102,'7等奖','2024-04-13 03:45:31','create','2024-04-13 11:45:30','2024-04-13 11:45:30'),
	(48,'xiaofuge',100301,100006,'940273728363',102,'7等奖','2024-04-13 04:14:53','create','2024-04-13 12:14:53','2024-04-13 12:14:53'),
	(49,'xiaofuge',100301,100006,'240699246294',104,'5等奖','2024-04-13 04:17:34','create','2024-04-13 12:17:33','2024-04-13 12:17:33'),
	(50,'xiaofuge',100301,100006,'298101180210',103,'6等奖','2024-04-13 04:18:17','create','2024-04-13 12:18:16','2024-04-13 12:18:16'),
	(51,'xiaofuge',100301,100006,'565655944488',103,'6等奖','2024-04-13 04:18:23','create','2024-04-13 12:18:23','2024-04-13 12:18:23'),
	(52,'xiaofuge',100301,100006,'090289257534',104,'5等奖','2024-04-13 04:18:25','create','2024-04-13 12:18:24','2024-04-13 12:18:24'),
	(53,'xiaofuge',100301,100006,'668356046426',105,'4等奖','2024-04-13 04:18:26','create','2024-04-13 12:18:25','2024-04-13 12:18:25'),
	(54,'xiaofuge',100301,100006,'745680068300',107,'2等奖','2024-04-13 04:18:37','create','2024-04-13 12:18:36','2024-04-13 12:18:36'),
	(55,'xiaofuge',100301,100006,'285300597983',102,'7等奖','2024-04-13 04:20:08','create','2024-04-13 12:20:07','2024-04-13 12:20:07'),
	(56,'xiaofuge',100301,100006,'999361306023',104,'5等奖','2024-04-13 04:20:10','create','2024-04-13 12:20:09','2024-04-13 12:20:09'),
	(57,'xiaofuge',100301,100006,'063682699381',104,'5等奖','2024-04-13 04:20:14','create','2024-04-13 12:20:13','2024-04-13 12:20:13'),
	(58,'xiaofuge',100301,100006,'680488311338',105,'4等奖','2024-04-13 04:20:15','create','2024-04-13 12:20:14','2024-04-13 12:20:14'),
	(59,'xiaofuge',100301,100006,'399058527457',102,'7等奖','2024-04-13 04:20:16','create','2024-04-13 12:20:16','2024-04-13 12:20:16'),
	(60,'xiaofuge',100301,100006,'579122416749',106,'3等奖','2024-04-13 04:20:21','create','2024-04-13 12:20:20','2024-04-13 12:20:20'),
	(61,'xiaofuge',100301,100006,'854484054432',102,'7等奖','2024-04-13 06:03:59','create','2024-04-13 14:03:59','2024-04-13 14:03:59'),
	(62,'xiaofuge',100301,100006,'066823147917',104,'5等奖','2024-04-13 07:25:06','create','2024-04-13 15:25:06','2024-04-13 15:25:06'),
	(63,'xiaofuge',100301,100006,'022620846137',102,'7等奖','2024-04-13 07:25:11','create','2024-04-13 15:25:11','2024-04-13 15:25:11'),
	(64,'xiaofuge',100301,100006,'605666354632',101,'随机积分','2024-04-13 07:25:12','create','2024-04-13 15:25:12','2024-04-13 15:25:12'),
	(65,'xiaofuge',100301,100006,'604661560037',107,'2等奖','2024-04-13 07:25:21','create','2024-04-13 15:25:21','2024-04-13 15:25:21'),
	(66,'xiaofuge',100301,100006,'212448652580',105,'4等奖','2024-04-20 04:09:31','create','2024-04-20 12:09:30','2024-04-20 12:09:30'),
	(67,'xiaofuge',100301,100006,'356729331179',106,'3等奖','2024-04-20 04:11:24','create','2024-04-20 12:11:24','2024-04-20 12:11:24'),
	(68,'xiaofuge',100301,100006,'102669494145',105,'4等奖','2024-04-20 07:10:58','create','2024-04-20 15:10:58','2024-04-20 15:10:58'),
	(69,'xiaofuge',100301,100006,'730186113832',107,'2等奖','2024-04-20 07:43:13','create','2024-04-20 15:43:13','2024-04-20 15:43:13'),
	(70,'xiaofuge',100301,100006,'472281891603',106,'3等奖','2024-04-20 08:50:39','create','2024-04-20 16:50:39','2024-04-20 16:50:39'),
	(71,'xiaofuge',100301,100006,'931181504757',108,'暴走玩偶','2024-04-27 05:19:39','create','2024-04-27 13:19:38','2024-04-27 13:19:38'),
	(72,'xiaofuge',100301,100006,'664993621684',101,'随机积分','2024-04-27 05:27:17','create','2024-04-27 13:27:17','2024-04-27 13:27:17'),
	(73,'xiaofuge',100301,100006,'757674779249',104,'小米台灯','2024-04-27 05:27:45','create','2024-04-27 13:27:45','2024-04-27 13:27:45'),
	(74,'xiaofuge',100301,100006,'623885952534',102,'OpenAI会员卡','2024-04-27 05:28:02','create','2024-04-27 13:28:01','2024-04-27 13:28:01'),
	(75,'xiaofuge',100301,100006,'351875766756',106,'轻奢办公椅','2024-04-27 05:29:05','create','2024-04-27 13:29:05','2024-04-27 13:29:05'),
	(76,'xiaofuge',100301,100006,'803227763198',103,'支付优惠券','2024-04-27 05:29:32','create','2024-04-27 13:29:31','2024-04-27 13:29:31'),
	(77,'xiaofuge',100301,100006,'587527322073',106,'轻奢办公椅','2024-04-27 05:29:57','create','2024-04-27 13:29:57','2024-04-27 13:29:57'),
	(78,'xiaofuge',100301,100006,'552928609772',107,'小霸王游戏机','2024-04-27 05:30:11','create','2024-04-27 13:30:11','2024-04-27 13:30:11'),
	(79,'xiaofuge',100301,100006,'407462568156',107,'小霸王游戏机','2024-04-27 05:36:27','create','2024-04-27 13:36:27','2024-04-27 13:36:27'),
	(80,'xiaofuge',100301,100006,'688519386935',101,'随机积分','2024-04-27 05:38:00','create','2024-04-27 13:38:00','2024-04-27 13:38:00'),
	(81,'xiaofuge',100301,100006,'148984382545',104,'小米台灯','2024-04-27 05:38:56','create','2024-04-27 13:38:55','2024-04-27 13:38:55'),
	(82,'xiaofuge',100301,100006,'410701479648',101,'随机积分','2024-04-27 05:39:18','create','2024-04-27 13:39:18','2024-04-27 13:39:18'),
	(83,'xiaofuge',100301,100006,'521226371540',101,'随机积分','2024-04-27 06:59:56','create','2024-04-27 14:59:56','2024-04-27 14:59:56'),
	(84,'xiaofuge',100301,100006,'167000751553',102,'OpenAI会员卡','2024-04-27 07:00:14','create','2024-04-27 15:00:14','2024-04-27 15:00:14'),
	(85,'xiaofuge',100301,100006,'685179511666',104,'小米台灯','2024-04-27 07:00:23','create','2024-04-27 15:00:22','2024-04-27 15:00:22');

/*!40000 ALTER TABLE `user_award_record_001` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user_award_record_002
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_award_record_002`;

CREATE TABLE `user_award_record_002` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int(11) NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_activity_id` (`activity_id`),
  KEY `idx_award_id` (`strategy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户中奖记录表';



# 转储表 user_award_record_003
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_award_record_003`;

CREATE TABLE `user_award_record_003` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int(11) NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_activity_id` (`activity_id`),
  KEY `idx_award_id` (`strategy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户中奖记录表';



# 转储表 user_behavior_rebate_order_000
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_behavior_rebate_order_000`;

CREATE TABLE `user_behavior_rebate_order_000` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `biz_id` varchar(64) NOT NULL COMMENT '业务ID - 拼接的唯一值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_biz_id` (`biz_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户行为返利流水订单表';



# 转储表 user_behavior_rebate_order_001
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_behavior_rebate_order_001`;

CREATE TABLE `user_behavior_rebate_order_001` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `biz_id` varchar(64) NOT NULL COMMENT '业务ID - 拼接的唯一值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_biz_id` (`biz_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户行为返利流水订单表';

LOCK TABLES `user_behavior_rebate_order_001` WRITE;
/*!40000 ALTER TABLE `user_behavior_rebate_order_001` DISABLE KEYS */;

INSERT INTO `user_behavior_rebate_order_001` (`id`, `user_id`, `order_id`, `behavior_type`, `rebate_desc`, `rebate_type`, `rebate_config`, `biz_id`, `create_time`, `update_time`)
VALUES
	(1,'xiaofuge','833814327101','sign','签到返利','sku','9011','xiaofuge_sku_20240430','2024-04-30 18:01:32','2024-04-30 18:01:32'),
	(3,'xiaofuge','509399206701','sign','签到返利-积分','integral','10','xiaofuge_integral_20240430','2024-04-30 18:05:44','2024-04-30 18:05:44');

/*!40000 ALTER TABLE `user_behavior_rebate_order_001` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user_behavior_rebate_order_002
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_behavior_rebate_order_002`;

CREATE TABLE `user_behavior_rebate_order_002` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `biz_id` varchar(64) NOT NULL COMMENT '业务ID - 拼接的唯一值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_biz_id` (`biz_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户行为返利流水订单表';



# 转储表 user_behavior_rebate_order_003
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_behavior_rebate_order_003`;

CREATE TABLE `user_behavior_rebate_order_003` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `biz_id` varchar(64) NOT NULL COMMENT '业务ID - 拼接的唯一值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  UNIQUE KEY `uq_biz_id` (`biz_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户行为返利流水订单表';



# 转储表 user_raffle_order_000
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_raffle_order_000`;

CREATE TABLE `user_raffle_order_000` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户抽奖订单表';



# 转储表 user_raffle_order_001
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_raffle_order_001`;

CREATE TABLE `user_raffle_order_001` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户抽奖订单表';

LOCK TABLES `user_raffle_order_001` WRITE;
/*!40000 ALTER TABLE `user_raffle_order_001` DISABLE KEYS */;

INSERT INTO `user_raffle_order_001` (`id`, `user_id`, `activity_id`, `activity_name`, `strategy_id`, `order_id`, `order_time`, `order_state`, `create_time`, `update_time`)
VALUES
	(5,'xiaofuge',100301,'测试活动',100006,'569856975978','2024-04-08 14:52:47','used','2024-04-08 22:52:47','2024-04-13 11:44:01'),
	(6,'xiaofuge',100301,'测试活动',100006,'867136698684','2024-04-13 03:44:07','used','2024-04-13 11:44:10','2024-04-13 11:44:10'),
	(7,'xiaofuge',100301,'测试活动',100006,'250425115608','2024-04-13 03:44:14','used','2024-04-13 11:44:14','2024-04-13 11:44:14'),
	(8,'xiaofuge',100301,'测试活动',100006,'663910993767','2024-04-13 03:44:16','used','2024-04-13 11:44:15','2024-04-13 11:44:15'),
	(9,'xiaofuge',100301,'测试活动',100006,'218374542905','2024-04-13 03:44:17','used','2024-04-13 11:44:16','2024-04-13 11:44:16'),
	(10,'xiaofuge',100301,'测试活动',100006,'225714694474','2024-04-13 03:44:18','used','2024-04-13 11:44:17','2024-04-13 11:44:17'),
	(11,'xiaofuge',100301,'测试活动',100006,'431167372778','2024-04-13 03:44:19','used','2024-04-13 11:44:18','2024-04-13 11:44:18'),
	(12,'xiaofuge',100301,'测试活动',100006,'434079846497','2024-04-13 03:45:30','used','2024-04-13 11:45:29','2024-04-13 11:45:29'),
	(13,'xiaofuge',100301,'测试活动',100006,'965685676429','2024-04-13 03:45:31','used','2024-04-13 11:45:30','2024-04-13 11:45:30'),
	(14,'xiaofuge',100301,'测试活动',100006,'940273728363','2024-04-13 04:14:53','used','2024-04-13 12:14:53','2024-04-13 12:14:53'),
	(15,'xiaofuge',100301,'测试活动',100006,'240699246294','2024-04-13 04:16:20','used','2024-04-13 12:16:19','2024-04-13 12:17:33'),
	(16,'xiaofuge',100301,'测试活动',100006,'298101180210','2024-04-13 04:18:05','used','2024-04-13 12:18:05','2024-04-13 12:18:16'),
	(17,'xiaofuge',100301,'测试活动',100006,'565655944488','2024-04-13 04:18:23','used','2024-04-13 12:18:23','2024-04-13 12:18:23'),
	(18,'xiaofuge',100301,'测试活动',100006,'090289257534','2024-04-13 04:18:25','used','2024-04-13 12:18:24','2024-04-13 12:18:24'),
	(19,'xiaofuge',100301,'测试活动',100006,'668356046426','2024-04-13 04:18:26','used','2024-04-13 12:18:25','2024-04-13 12:18:25'),
	(20,'xiaofuge',100301,'测试活动',100006,'745680068300','2024-04-13 04:18:27','used','2024-04-13 12:18:26','2024-04-13 12:18:36'),
	(21,'xiaofuge',100301,'测试活动',100006,'285300597983','2024-04-13 04:20:07','used','2024-04-13 12:20:07','2024-04-13 12:20:07'),
	(22,'xiaofuge',100301,'测试活动',100006,'999361306023','2024-04-13 04:20:10','used','2024-04-13 12:20:09','2024-04-13 12:20:09'),
	(23,'xiaofuge',100301,'测试活动',100006,'063682699381','2024-04-13 04:20:14','used','2024-04-13 12:20:13','2024-04-13 12:20:13'),
	(24,'xiaofuge',100301,'测试活动',100006,'680488311338','2024-04-13 04:20:15','used','2024-04-13 12:20:14','2024-04-13 12:20:14'),
	(25,'xiaofuge',100301,'测试活动',100006,'399058527457','2024-04-13 04:20:16','used','2024-04-13 12:20:16','2024-04-13 12:20:16'),
	(26,'xiaofuge',100301,'测试活动',100006,'579122416749','2024-04-13 04:20:17','used','2024-04-13 12:20:17','2024-04-13 12:20:20'),
	(27,'xiaofuge',100301,'测试活动',100006,'854484054432','2024-04-13 06:03:59','used','2024-04-13 14:03:59','2024-04-13 14:03:59'),
	(28,'xiaofuge',100301,'测试活动',100006,'066823147917','2024-04-13 07:24:59','used','2024-04-13 15:25:05','2024-04-13 15:25:06'),
	(29,'xiaofuge',100301,'测试活动',100006,'022620846137','2024-04-13 07:25:11','used','2024-04-13 15:25:11','2024-04-13 15:25:11'),
	(30,'xiaofuge',100301,'测试活动',100006,'605666354632','2024-04-13 07:25:12','used','2024-04-13 15:25:12','2024-04-13 15:25:12'),
	(31,'xiaofuge',100301,'测试活动',100006,'604661560037','2024-04-13 07:25:13','used','2024-04-13 15:25:13','2024-04-13 15:25:21'),
	(32,'xiaofuge',100301,'测试活动',100006,'212448652580','2024-04-20 04:09:30','used','2024-04-20 12:09:30','2024-04-20 12:09:30'),
	(33,'xiaofuge',100301,'测试活动',100006,'356729331179','2024-04-20 04:11:24','used','2024-04-20 12:11:24','2024-04-20 12:11:24'),
	(34,'xiaofuge',100301,'测试活动',100006,'102669494145','2024-04-20 07:10:44','used','2024-04-20 15:10:44','2024-04-20 15:10:58'),
	(35,'xiaofuge',100301,'测试活动',100006,'730186113832','2024-04-20 07:43:12','used','2024-04-20 15:43:12','2024-04-20 15:43:13'),
	(36,'xiaofuge',100301,'测试活动',100006,'472281891603','2024-04-20 08:50:37','used','2024-04-20 16:50:38','2024-04-20 16:50:39'),
	(37,'xiaofuge',100301,'测试活动',100006,'931181504757','2024-04-27 05:19:26','used','2024-04-27 13:19:26','2024-04-27 13:19:38'),
	(38,'xiaofuge',100301,'测试活动',100006,'664993621684','2024-04-27 05:26:49','used','2024-04-27 13:26:49','2024-04-27 13:27:17'),
	(39,'xiaofuge',100301,'测试活动',100006,'757674779249','2024-04-27 05:27:45','used','2024-04-27 13:27:45','2024-04-27 13:27:45'),
	(40,'xiaofuge',100301,'测试活动',100006,'623885952534','2024-04-27 05:28:02','used','2024-04-27 13:28:01','2024-04-27 13:28:01'),
	(41,'xiaofuge',100301,'测试活动',100006,'351875766756','2024-04-27 05:29:05','used','2024-04-27 13:29:05','2024-04-27 13:29:05'),
	(42,'xiaofuge',100301,'测试活动',100006,'803227763198','2024-04-27 05:29:32','used','2024-04-27 13:29:31','2024-04-27 13:29:31'),
	(43,'xiaofuge',100301,'测试活动',100006,'587527322073','2024-04-27 05:29:57','used','2024-04-27 13:29:57','2024-04-27 13:29:57'),
	(44,'xiaofuge',100301,'测试活动',100006,'552928609772','2024-04-27 05:30:11','used','2024-04-27 13:30:11','2024-04-27 13:30:11'),
	(45,'xiaofuge',100301,'测试活动',100006,'407462568156','2024-04-27 05:36:27','used','2024-04-27 13:36:27','2024-04-27 13:36:27'),
	(46,'xiaofuge',100301,'测试活动',100006,'688519386935','2024-04-27 05:38:00','used','2024-04-27 13:38:00','2024-04-27 13:38:00'),
	(47,'xiaofuge',100301,'测试活动',100006,'148984382545','2024-04-27 05:38:56','used','2024-04-27 13:38:55','2024-04-27 13:38:55'),
	(48,'xiaofuge',100301,'测试活动',100006,'410701479648','2024-04-27 05:39:18','used','2024-04-27 13:39:18','2024-04-27 13:39:18'),
	(49,'xiaofuge',100301,'测试活动',100006,'521226371540','2024-04-27 06:59:56','used','2024-04-27 14:59:56','2024-04-27 14:59:56'),
	(50,'xiaofuge',100301,'测试活动',100006,'167000751553','2024-04-27 07:00:14','used','2024-04-27 15:00:14','2024-04-27 15:00:14'),
	(51,'xiaofuge',100301,'测试活动',100006,'685179511666','2024-04-27 07:00:23','used','2024-04-27 15:00:22','2024-04-27 15:00:22');

/*!40000 ALTER TABLE `user_raffle_order_001` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user_raffle_order_002
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_raffle_order_002`;

CREATE TABLE `user_raffle_order_002` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户抽奖订单表';



# 转储表 user_raffle_order_003
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_raffle_order_003`;

CREATE TABLE `user_raffle_order_003` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_order_id` (`order_id`),
  KEY `idx_user_id_activity_id` (`user_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户抽奖订单表';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
