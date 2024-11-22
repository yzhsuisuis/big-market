package cn.bugstack.domain.activity.service.quota.policy.impl;

import cn.bugstack.domain.activity.model.aggregate.CreateQuotaOrderAggregate;
import cn.bugstack.domain.activity.model.valobj.OrderStateVO;
import cn.bugstack.domain.activity.repository.IActivityRepository;
import cn.bugstack.domain.activity.service.quota.policy.ITradePolicy;

import java.math.BigDecimal;

public class RebateNoPayTradePolicy implements ITradePolicy {
    private final IActivityRepository activityRepository;
    public RebateNoPayTradePolicy(IActivityRepository activityRepository)
    {
        this.activityRepository = activityRepository;
    }
    @Override
    public void trade(CreateQuotaOrderAggregate createQuotaOrderAggregate) {
        /*
        * 这里的createQuotaOrderAggregate
        * 包含 -----> totalmount
        *            monthmount
        *            daymount
        *            activityOrderEntity(订单实体)
        *            设置订单状态的方法
        * */
        //用户签到返利 --->活动余额增加
        createQuotaOrderAggregate.setOrderState(OrderStateVO.completed);
        //把订单实体中payMount改为0
        createQuotaOrderAggregate.getActivityOrderEntity().setPayAmount(BigDecimal.ZERO);
        activityRepository.doSaveNoPayOrder(createQuotaOrderAggregate);

    }
}
