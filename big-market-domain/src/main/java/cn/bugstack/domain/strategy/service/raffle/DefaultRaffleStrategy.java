package cn.bugstack.domain.strategy.service.raffle;

import cn.bugstack.domain.strategy.model.entity.RaffleFactorEntity;
import cn.bugstack.domain.strategy.model.entity.RuleActionEntity;
import cn.bugstack.domain.strategy.model.entity.RuleMatterEntity;
import cn.bugstack.domain.strategy.model.valobj.RuleLogicCheckTypeVO;
import cn.bugstack.domain.strategy.repository.IStrategyRepository;
import cn.bugstack.domain.strategy.service.AbstractRaffleStrategy;
import cn.bugstack.domain.strategy.service.armory.IStrategyDispatch;
import cn.bugstack.domain.strategy.service.rule.filter.ILogicFilter;
import cn.bugstack.domain.strategy.service.rule.filter.factory.DefaultLogicFactory;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
public class DefaultRaffleStrategy extends AbstractRaffleStrategy {

	@Resource
	private DefaultLogicFactory logicFactory;

	public DefaultRaffleStrategy(IStrategyRepository repository, IStrategyDispatch strategyDispatch) {
		super(repository, strategyDispatch);
	}

	@Override
	//这里传的是rule_weight,....
	protected RuleActionEntity<RuleActionEntity.RaffleBeforeEntity> doCheckRaffleBeforeLogic(RaffleFactorEntity raffleFactorEntity, String... logics) {
		//1. 获取map集合 rule_model(key)   --- BlackListFilter(value)
		Map<String, ILogicFilter<RuleActionEntity.RaffleBeforeEntity>> logicFilterGroup = logicFactory.openLogicFilter();
		if (logics == null || 0 == logics.length) {
			return RuleActionEntity.<RuleActionEntity.RaffleBeforeEntity>builder()
					.code(RuleLogicCheckTypeVO.ALLOW.getCode())
					.info(RuleLogicCheckTypeVO.ALLOW.getInfo())
					.build();
		}
		//2. 从传进来的可变参数logic,来查看是否有目标过滤规则
		String ruleBlackList = Arrays.stream(logics).filter(str -> str.contains(DefaultLogicFactory.LogicModel.RULE_BLACKLIST.getCode()))
				.findFirst()
				.orElse(null);
		//3.判断是否有某个过滤规则参数
		if(StringUtils.isNotBlank(ruleBlackList))
		{
			//从map中获得对应的过滤链
			ILogicFilter<RuleActionEntity.RaffleBeforeEntity> logicFilter = logicFilterGroup.get(DefaultLogicFactory.LogicModel.RULE_BLACKLIST.getCode());
            //logicFilter.filter ,这里需要传入一个matter,所以需要手动封装一下
			RuleMatterEntity ruleMatterEntity = new RuleMatterEntity();
/*			String userId = ruleMatterEntity.getUserId();
			Long strategyId = ruleMatterEntity.getStrategyId();
			Integer awardId = ruleMatterEntity.getAwardId();
			String ruleModel = ruleMatterEntity.getRuleModel();*/
			ruleMatterEntity.setUserId(raffleFactorEntity.getUserId());
			ruleMatterEntity.setStrategyId(raffleFactorEntity.getStrategyId());
			ruleMatterEntity.setAwardId(ruleMatterEntity.getAwardId());
			ruleMatterEntity.setRuleModel(DefaultLogicFactory.LogicModel.RULE_BLACKLIST.getCode());
			//这里只是告诉你,你的规则动作
			RuleActionEntity<RuleActionEntity.RaffleBeforeEntity> ruleActionEntity = logicFilter.filter(ruleMatterEntity);
			if(!RuleLogicCheckTypeVO.ALLOW.getCode().equals(ruleActionEntity.getCode())) {
				return ruleActionEntity;
			}
		}
		// 顺序过滤剩余规则
		List<String> ruleList = Arrays.stream(logics)
				.filter(s -> !s.equals(DefaultLogicFactory.LogicModel.RULE_BLACKLIST.getCode()))
				.collect(Collectors.toList());

		RuleActionEntity<RuleActionEntity.RaffleBeforeEntity> ruleActionEntity = null;
		for (String ruleModel : ruleList) {
			ILogicFilter<RuleActionEntity.RaffleBeforeEntity> logicFilter = logicFilterGroup.get(ruleModel);
			RuleMatterEntity ruleMatterEntity = new RuleMatterEntity();
			ruleMatterEntity.setUserId(raffleFactorEntity.getUserId());
			ruleMatterEntity.setAwardId(ruleMatterEntity.getAwardId());
			ruleMatterEntity.setStrategyId(raffleFactorEntity.getStrategyId());
			ruleMatterEntity.setRuleModel(ruleModel);
			ruleActionEntity = logicFilter.filter(ruleMatterEntity);
			// 非放行结果则顺序过滤
			log.info("抽奖前规则过滤 userId: {} ruleModel: {} code: {} info: {}", raffleFactorEntity.getUserId(), ruleModel, ruleActionEntity.getCode(), ruleActionEntity.getInfo());
			if (!RuleLogicCheckTypeVO.ALLOW.getCode().equals(ruleActionEntity.getCode())) {
				return ruleActionEntity;
			}
		}

		return ruleActionEntity;





	}

	@Override
	protected RuleActionEntity<RuleActionEntity.RaffleCenterEntity> doCheckRaffleCenterLogic(RaffleFactorEntity raffleFactorEntity, String... logics) {
		if (logics == null || 0 == logics.length) {
			return RuleActionEntity.<RuleActionEntity.RaffleCenterEntity>builder()
					.code(RuleLogicCheckTypeVO.ALLOW.getCode())
					.info(RuleLogicCheckTypeVO.ALLOW.getInfo())
					.build();
		}

		Map<String, ILogicFilter<RuleActionEntity.RaffleCenterEntity>> logicFilterGroup = logicFactory.openLogicFilter();

		RuleActionEntity<RuleActionEntity.RaffleCenterEntity> ruleActionEntity = null;
		for (String ruleModel : logics) {
			ILogicFilter<RuleActionEntity.RaffleCenterEntity> logicFilter = logicFilterGroup.get(ruleModel);
			RuleMatterEntity ruleMatterEntity = new RuleMatterEntity();
			ruleMatterEntity.setUserId(raffleFactorEntity.getUserId());
			ruleMatterEntity.setAwardId(raffleFactorEntity.getAwardId());
			ruleMatterEntity.setStrategyId(raffleFactorEntity.getStrategyId());
			ruleMatterEntity.setRuleModel(ruleModel);
			ruleActionEntity = logicFilter.filter(ruleMatterEntity);
			// 非放行结果则顺序过滤
			log.info("抽奖中规则过滤 userId: {} ruleModel: {} code: {} info: {}", raffleFactorEntity.getUserId(), ruleModel, ruleActionEntity.getCode(), ruleActionEntity.getInfo());
			if (!RuleLogicCheckTypeVO.ALLOW.getCode().equals(ruleActionEntity.getCode())) {
				return ruleActionEntity;
			}
		}
		return ruleActionEntity;
	}
}