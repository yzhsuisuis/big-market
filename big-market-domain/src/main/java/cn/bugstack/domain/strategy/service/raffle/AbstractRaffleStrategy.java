package cn.bugstack.domain.strategy.service.raffle;

import cn.bugstack.domain.strategy.model.entity.RaffleAwardEntity;
import cn.bugstack.domain.strategy.model.entity.RaffleFactorEntity;
import cn.bugstack.domain.strategy.model.entity.RuleActionEntity;
import cn.bugstack.domain.strategy.model.entity.StrategyEntity;
import cn.bugstack.domain.strategy.model.valobj.RuleLogicCheckTypeVO;
import cn.bugstack.domain.strategy.model.valobj.StrategyAwardRuleModelVO;
import cn.bugstack.domain.strategy.repository.IStrategyRepository;
import cn.bugstack.domain.strategy.service.IRaffleStrategy;
import cn.bugstack.domain.strategy.service.armory.IStrategyDispatch;
import cn.bugstack.domain.strategy.service.rule.factory.DefaultLogicFactory;
import cn.bugstack.types.enums.ResponseCode;
import cn.bugstack.types.exception.AppException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

@Slf4j
public abstract class AbstractRaffleStrategy implements IRaffleStrategy {

	// 策略仓储服务 -> domain层像一个大厨，仓储层提供米面粮油
	protected IStrategyRepository repository;
	//  策略调度服务 -> 只负责抽奖处理，通过新增接口的方式，隔离职责，不需要使用方关心或者调用抽奖的初始化
	protected IStrategyDispatch strategyDispatch;

	public AbstractRaffleStrategy(IStrategyRepository repository, IStrategyDispatch strategyDispatch) {
		this.repository = repository;
		this.strategyDispatch = strategyDispatch;
	}

	@Override
	public RaffleAwardEntity performRaffle(RaffleFactorEntity raffleFactorEntity) {
		// 1. 参数校验
		String userId = raffleFactorEntity.getUserId();
		Long strategyId = raffleFactorEntity.getStrategyId();
		if (null == strategyId || StringUtils.isBlank(userId)) {
			throw new AppException(ResponseCode.ILLEGAL_PARAMETER.getCode(), ResponseCode.ILLEGAL_PARAMETER.getInfo());
		}

		// 2. 策略查询
		StrategyEntity strategy = repository.queryStrategyEntityByStrategyId(strategyId);
		log.info(" "+strategy);

		//3. 根据策略查询到策略的执行链
		RuleActionEntity<RuleActionEntity.RaffleBeforeEntity> ruleActionEntity = this.doCheckRaffleBeforeLogic(raffleFactorEntity,
				strategy.ruleModels());
		//4. 这里的actionEntity分三类
		if(RuleLogicCheckTypeVO.TAKE_OVER.getCode().equals(ruleActionEntity.getCode()))
		{
			//这里代表策略的Model不为空,可以接管
			if(DefaultLogicFactory.LogicModel.RULE_BLACKLIST.getCode().equals(ruleActionEntity.getRuleModel()))
			{
				//执行黑名单
				return RaffleAwardEntity.builder()
						.awardId(ruleActionEntity.getData().getAwardId())
						.build();
			}
			else if(DefaultLogicFactory.LogicModel.RULE_WIGHT.getCode().equals(ruleActionEntity.getRuleModel()))
			{
				RuleActionEntity.RaffleBeforeEntity raffleBeforeEtity = ruleActionEntity.getData();
				String ruleWeightValueKey = raffleBeforeEtity.getRuleWeightValueKey();
				Integer randomAwardId = strategyDispatch.getRandomAwardId(strategyId, ruleWeightValueKey);
				return RaffleAwardEntity.builder()
						.awardId(randomAwardId)
						.build();
			}
		}
		// 啥事都没有发生,默认抽奖流程
		Integer awardId = strategyDispatch.getRandomAwardId(strategyId);

		//抽奖中的规则: 此时已经拿到了理论上抽到的奖品id了,但是由于有些奖品有自己的规则,所以
		//抽奖后返回的不一定是最开始抽到的那个奖品id(例如没资格拿奖或者库存不够的时候都是走兜底的)
		StrategyAwardRuleModelVO strategyAwardRuleModelVO = repository.queryStrategyAwardRuleModelVO(strategyId, awardId);
		// 6. 抽奖中 - 规则过滤
		RuleActionEntity<RuleActionEntity.RaffleCenterEntity> ruleActionCenterEntity = this.doCheckRaffleCenterLogic(RaffleFactorEntity.builder()
				.userId(userId)
				.strategyId(strategyId)
				.awardId(awardId)
				.build(), strategyAwardRuleModelVO.raffleCenterRuleModelList());

		if (RuleLogicCheckTypeVO.TAKE_OVER.getCode().equals(ruleActionCenterEntity.getCode())){
			log.info("【临时日志】中奖中规则拦截，通过抽奖后规则 rule_luck_award 走兜底奖励。");
			return RaffleAwardEntity.builder()
					.awardDesc("中奖中规则拦截，通过抽奖后规则 rule_luck_award 走兜底奖励。")
					.build();
		}


		return RaffleAwardEntity.builder()
				.awardId(awardId)
				.build();

	}
	protected abstract RuleActionEntity<RuleActionEntity.RaffleBeforeEntity> doCheckRaffleBeforeLogic(RaffleFactorEntity raffleFactorEntity, String... logics);

	protected abstract RuleActionEntity<RuleActionEntity.RaffleCenterEntity> doCheckRaffleCenterLogic(RaffleFactorEntity raffleFactorEntity, String... logics);
}
