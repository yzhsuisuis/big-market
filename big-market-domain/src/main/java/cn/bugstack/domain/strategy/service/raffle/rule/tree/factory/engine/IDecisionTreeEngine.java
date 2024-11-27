package cn.bugstack.domain.strategy.service.raffle.rule.tree.factory.engine;

import cn.bugstack.domain.strategy.service.raffle.rule.tree.factory.DefaultTreeFactory;

import java.util.Date;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 规则树组合接口
 * @create 2024-01-27 11:33
 */
public interface IDecisionTreeEngine {

    DefaultTreeFactory.StrategyAwardVO process(String userId, Long strategyId, Integer awardId, Date endDateTime);

}
