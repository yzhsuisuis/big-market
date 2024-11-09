package cn.bugstack.trigger.api.dto;

import lombok.Data;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 抽奖奖品列表，请求对象
 * @create 2024-02-14 09:46
 */
@Data
public class RaffleAwardListRequestDTO {
    //之前都是直接根据策略查询的奖品,现在要改了,要根据用户id和活动id
    //很重要的一点是这里的userId是String类型的
    private String UserId;

    private Long ActivityId;
    //    // 抽奖策略ID
//    private Long strategyId;

}
