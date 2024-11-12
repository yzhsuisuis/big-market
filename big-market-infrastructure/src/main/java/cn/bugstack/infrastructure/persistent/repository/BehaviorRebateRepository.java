package cn.bugstack.infrastructure.persistent.repository;

import cn.bugstack.domain.rebate.model.valobj.BehaviorTypeVO;
import cn.bugstack.domain.rebate.model.valobj.DailyBehaviorRebateVO;
import cn.bugstack.domain.rebate.repository.IBehaviorRebateRepository;
import cn.bugstack.infrastructure.persistent.dao.IDailyBehaviorRebateDao;
import cn.bugstack.infrastructure.persistent.po.DailyBehaviorRebate;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

public class BehaviorRebateRepository implements IBehaviorRebateRepository {
    @Resource
    private IDailyBehaviorRebateDao dailyBehaviorRebateDao;
    @Override
    public List<DailyBehaviorRebateVO> queryDailyBehaviorRebateConfig(BehaviorTypeVO behaviorTypeVO) {
        //去查状态为open的
        List<DailyBehaviorRebate> dailyBehaviorRebates = dailyBehaviorRebateDao.queryDailyBehaviorRebateByBehaviorType(behaviorTypeVO.getCode());
        //不需要在这里进行判空,因为这个只是一个仓储类型
        ArrayList<DailyBehaviorRebateVO> dailyBehaviorRebateVOS = new ArrayList<>(dailyBehaviorRebates.size());
        for (DailyBehaviorRebate dailyBehaviorRebate : dailyBehaviorRebates) {
            dailyBehaviorRebateVOS.add(DailyBehaviorRebateVO.builder()
                            .behaviorType(dailyBehaviorRebate.getBehaviorType())
                            .rebateConfig(dailyBehaviorRebate.getRebateConfig())
                            .rebateDesc(dailyBehaviorRebate.getRebateDesc())
                            .rebateType(dailyBehaviorRebate.getRebateType())
                    .build());


        }
        return dailyBehaviorRebateVOS;
    }
}
