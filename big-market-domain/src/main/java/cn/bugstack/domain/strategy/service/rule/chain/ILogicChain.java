package cn.bugstack.domain.strategy.service.rule.chain;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 抽奖策略规则责任链接口
 * @create 2024-01-20 09:40
 */
public interface ILogicChain extends ILogicChainArmory{

    /**
     * 责任链接口
     *
     * @param userId     用户ID
     * @param strategyId 策略ID
     * @return 奖品ID
     */
    Integer logic(String userId, Long strategyId);

}
