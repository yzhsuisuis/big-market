//package cn.bugstack.domain.rebate.service;
//
//import cn.bugstack.domain.rebate.aggregate.BehaviorRebateAggregate;
//import cn.bugstack.domain.rebate.model.entity.BehaviorEntity;
//import cn.bugstack.domain.rebate.model.valobj.DailyBehaviorRebateVO;
//import cn.bugstack.domain.rebate.repository.IBehaviorRebateRepository;
//import cn.bugstack.types.common.Constants;
//
//import javax.annotation.Resource;
//import java.util.ArrayList;
//import java.util.List;
//
//public class BehaviorRebateService implements IBehaviorRebateService{
//    @Resource
//    private IBehaviorRebateRepository behaviorRebateRepository;
//    @Override
//    public List<String> createOrder(BehaviorEntity behaviorEntity) {
//        //userId和用户行为的枚举类
//        //1. 根据用户行为类型,获取返利配置
//        List<DailyBehaviorRebateVO> dailyBehaviorRebateVOS = behaviorRebateRepository.queryDailyBehaviorRebateConfig(behaviorEntity.getBehaviorTypeVO());
//        if(null == dailyBehaviorRebateVOS || dailyBehaviorRebateVOS.isEmpty()) return new ArrayList<>();
//
//        //2.构建聚合对象,最后返回的仅仅是一个orderIds对象
//        List<String> orderIds = new ArrayList<>();
//        ArrayList<BehaviorRebateAggregate> behaviorRebateAggregates = new ArrayList<>();
//        for (DailyBehaviorRebateVO dailyBehaviorRebateVO : dailyBehaviorRebateVOS) {
//            //拼装成一个bid
//            String bizId = behaviorEntity.getUserId() + Constants.UNDERLINE + dailyBehaviorRebateVO.getRebateType() + Constants.UNDERLINE + behaviorEntity.getOutBusinessNo();
//
//        }
//
//
//    }
//}
