package cn.bugstack.domain.strategy.service.rule.impl;

import cn.bugstack.domain.strategy.model.entity.RuleActionEntity;
import cn.bugstack.domain.strategy.model.entity.RuleMatterEntity;
import cn.bugstack.domain.strategy.model.valobj.RuleLogicCheckTypeVO;
import cn.bugstack.domain.strategy.repository.IStrategyRepository;
import cn.bugstack.domain.strategy.service.annotation.LogicStrategy;
import cn.bugstack.domain.strategy.service.rule.ILogicFilter;
import cn.bugstack.domain.strategy.service.rule.factory.DefaultLogicFactory;
import cn.bugstack.types.common.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Slf4j
@Component
@LogicStrategy(logicMode = DefaultLogicFactory.LogicModel.RULE_BLACKLIST)
public class RuleBlackListLogicFilter implements ILogicFilter<RuleActionEntity.RaffleBeforeEntity> {

	@Resource
	private IStrategyRepository repository;

	@Override
	public RuleActionEntity<RuleActionEntity.RaffleBeforeEntity> filter(RuleMatterEntity ruleMatterEntity) {
		log.info("规则过滤-黑名单 userId:{} strategyId:{} ruleModel:{}", ruleMatterEntity.getUserId(), ruleMatterEntity.getStrategyId(), ruleMatterEntity.getRuleModel());

		String userId = ruleMatterEntity.getUserId();

		// 查询规则值配置
		String ruleValue = repository.queryStrategyRuleValue(ruleMatterEntity.getStrategyId(), ruleMatterEntity.getAwardId(), ruleMatterEntity.getRuleModel());
		String[] splitRuleValue = ruleValue.split(Constants.COLON);
		Integer awardId = Integer.parseInt(splitRuleValue[0]);
		//100:user001,user002,user003,user004

		String[] userBlackIds = splitRuleValue[1].split(Constants.SPLIT);
		for (String userBlackId : userBlackIds) {
			if(userId.equals(userBlackId))
			{
				//在黑名单名列中
				return RuleActionEntity.<RuleActionEntity.RaffleBeforeEntity>builder()
						.ruleModel(DefaultLogicFactory.LogicModel.RULE_BLACKLIST.getCode())
						.data(RuleActionEntity.RaffleBeforeEntity.builder()
								.strategyId(ruleMatterEntity.getStrategyId())
								.awardId(awardId)
								.build())
						.info(RuleLogicCheckTypeVO.TAKE_OVER.getInfo())
						.code(RuleLogicCheckTypeVO.TAKE_OVER.getCode())
						.build();
			}
		}
		return RuleActionEntity.<RuleActionEntity.RaffleBeforeEntity>builder()
				.code(RuleLogicCheckTypeVO.ALLOW.getCode())
				.info(RuleLogicCheckTypeVO.ALLOW.getInfo())
				.build();
	}
}