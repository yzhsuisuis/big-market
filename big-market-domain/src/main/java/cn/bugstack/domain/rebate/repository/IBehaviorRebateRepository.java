package cn.bugstack.domain.rebate.repository;

import cn.bugstack.domain.rebate.aggregate.BehaviorRebateAggregate;
import cn.bugstack.domain.rebate.model.valobj.BehaviorTypeVO;
import cn.bugstack.domain.rebate.model.valobj.DailyBehaviorRebateVO;

import java.util.ArrayList;
import java.util.List;

public interface IBehaviorRebateRepository {
    List<DailyBehaviorRebateVO> queryDailyBehaviorRebateConfig(BehaviorTypeVO behaviorTypeVO);

    void saveUserRebateRecord(String userId, ArrayList<BehaviorRebateAggregate> behaviorRebateAggregates);
}
