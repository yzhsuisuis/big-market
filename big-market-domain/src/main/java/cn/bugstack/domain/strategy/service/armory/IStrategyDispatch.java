package cn.bugstack.domain.strategy.service.armory;

public interface IStrategyDispatch {



    /**
     * 先根据策略id全部装配
     * @param strategyId
     * @return
     */
    Integer getRandomAwardId(Long strategyId);

    /**
     * 根据策略id和权重 4000: 107,108,109,110
     * @param strategyId
     * @param ruleWeightValue
     * @return
     */
    Integer getRandomAwardId(Long strategyId, String ruleWeightValue);

}