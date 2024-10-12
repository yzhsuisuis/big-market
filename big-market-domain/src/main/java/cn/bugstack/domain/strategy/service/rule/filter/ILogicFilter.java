package cn.bugstack.domain.strategy.service.rule.filter;

import cn.bugstack.domain.strategy.model.entity.RuleActionEntity;
import cn.bugstack.domain.strategy.model.entity.RuleMatterEntity;

public interface ILogicFilter<T extends RuleActionEntity.RaffleEntity> {

	RuleActionEntity<T> filter(RuleMatterEntity ruleMatterEntity);

}