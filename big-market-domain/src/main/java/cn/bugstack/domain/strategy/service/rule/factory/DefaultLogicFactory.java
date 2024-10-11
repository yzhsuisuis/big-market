package cn.bugstack.domain.strategy.service.rule.factory;

import cn.bugstack.domain.strategy.model.entity.RuleActionEntity;
import cn.bugstack.domain.strategy.service.annotation.LogicStrategy;
import cn.bugstack.domain.strategy.service.rule.ILogicFilter;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
@Service
public class DefaultLogicFactory {
	//用来存rule_model(key) --- 对应的Filter链(value)
	public Map<String, ILogicFilter<?>> logicFilterMap = new ConcurrentHashMap<>();

	public DefaultLogicFactory(List<ILogicFilter<?>> logicFilters) {
		logicFilters.forEach(logic -> {
			//这里的AnnotationUtils方法是用来判断logic这个类上面是否存在logicStrategy这个注解
			LogicStrategy strategy = AnnotationUtils.findAnnotation(logic.getClass(), LogicStrategy.class);
			if (null != strategy) {
				//这里的logic才是真正的拦截逻辑链
				logicFilterMap.put(strategy.logicMode().getCode(), logic);
			}
		});
	}
	public <T extends RuleActionEntity.RaffleEntity> Map<String, ILogicFilter<T>> openLogicFilter() {
		return (Map<String, ILogicFilter<T>>) (Map<?, ?>) logicFilterMap;
	}


	@Getter
	@AllArgsConstructor
	public enum LogicModel {

		RULE_WIGHT("rule_weight","【抽奖前规则】根据抽奖权重返回可抽奖范围KEY"),
		RULE_BLACKLIST("rule_blacklist","【抽奖前规则】黑名单规则过滤，命中黑名单则直接返回"),

		;

		private final String code;
		private final String info;

	}



}
