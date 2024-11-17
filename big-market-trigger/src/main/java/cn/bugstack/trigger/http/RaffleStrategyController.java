package cn.bugstack.trigger.http;

import cn.bugstack.domain.activity.service.IRaffleActivityAccountQuotaService;
import cn.bugstack.domain.strategy.model.entity.RaffleAwardEntity;
import cn.bugstack.domain.strategy.model.entity.RaffleFactorEntity;
import cn.bugstack.domain.strategy.model.entity.StrategyAwardEntity;
import cn.bugstack.domain.strategy.model.valobj.RuleWeightVO;
import cn.bugstack.domain.strategy.service.IRaffleAward;
import cn.bugstack.domain.strategy.service.IRaffleRule;
import cn.bugstack.domain.strategy.service.IRaffleStrategy;
import cn.bugstack.domain.strategy.service.armory.IStrategyArmory;
import cn.bugstack.trigger.api.IRaffleStrategyService;
import cn.bugstack.trigger.api.dto.*;
import cn.bugstack.types.enums.ResponseCode;
import cn.bugstack.types.exception.AppException;
import cn.bugstack.types.model.Response;
import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 营销抽奖服务
 * @create 2024-02-14 09:21
 */
@Slf4j
@RestController()
@CrossOrigin("${app.config.cross-origin}")
@RequestMapping("/api/${app.config.api-version}/raffle/strategy/")
public class RaffleStrategyController implements IRaffleStrategyService {

    @Resource
    private IRaffleAward raffleAward;
    @Resource
    private IRaffleRule raffleRule;
    @Resource
    private IRaffleStrategy raffleStrategy;
    @Resource
    private IStrategyArmory strategyArmory;
    @Resource
    private IRaffleActivityAccountQuotaService raffleActivityAccountQuotaService;

    /**
     * 策略装配，将策略信息装配到缓存中
     * <a href="http://localhost:8091/api/v1/raffle/strategy/strategy_armory">/api/v1/raffle/strategy/strategy_armory</a>
     *
     * @param strategyId 策略ID
     * @return 装配结果
     */
    @RequestMapping(value = "strategy_armory", method = RequestMethod.GET)
    @Override
    public Response<Boolean> strategyArmory(@RequestParam Long strategyId) {
        try {
            log.info("抽奖策略装配开始 strategyId：{}", strategyId);
            boolean armoryStatus = strategyArmory.assembleLotteryStrategy(strategyId);
            Response<Boolean> response = Response.<Boolean>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(armoryStatus)
                    .build();
            log.info("抽奖策略装配完成 strategyId：{} response: {}", strategyId, JSON.toJSONString(response));
            return response;
        } catch (Exception e) {
            log.error("抽奖策略装配失败 strategyId：{}", strategyId, e);
            return Response.<Boolean>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .build();
        }
    }

    /**
     * 查询奖品列表
     * * <a href="http://localhost:8091/api/v1/raffle/strategy/query_raffle_award_list">/api/v1/raffle/strategy/query_raffle_award_list</a>
     * 请求参数 raw json
     *
     * @param request {"strategyId":1000001}
     * @return 奖品列表
     */
    @RequestMapping(value = "query_raffle_award_list", method = RequestMethod.POST)
    @Override
    public Response<List<RaffleAwardListResponseDTO>> queryRaffleAwardList(@RequestBody RaffleAwardListRequestDTO request) {
        try {
            log.info("查询抽奖奖品列表配开始 userId:{} activityId：{}", request.getUserId(), request.getActivityId());
            if(StringUtils.isBlank(request.getUserId()) || null == request.getActivityId())
            {
                throw new AppException(ResponseCode.ILLEGAL_PARAMETER.getCode(),ResponseCode.ILLEGAL_PARAMETER.getInfo());
            }
            // 查询奖品配置
            List<StrategyAwardEntity> strategyAwardEntities = raffleAward.queryRaffleStrategyAwardListByActivityId(request.getActivityId());

            //获取规则配置,现在获得
            String[] treeIds = strategyAwardEntities.stream()
                    .map(StrategyAwardEntity::getRuleModels)
                    .filter(ruleModel -> ruleModel != null && !ruleModel.isEmpty())
                    .toArray(String[]::new);
            // 4. 查询规则配置 - 获取奖品的解锁限制，抽奖N次后解锁
            //这里对应的是tree_lock_1  -- 1,tree_lock_2 --- 2
            Map<String, Integer> ruleLockMap = raffleRule.queryAwardRuleLockCount(treeIds);
            //5.查询用户已经参与的抽奖次数,与第4步交相呼应
            Integer dayPartakeCount = raffleActivityAccountQuotaService.queryRaffleActivityAccountDayPartakeCount(request.getActivityId(), request.getUserId());
            //6. 开始封装
            ArrayList<RaffleAwardListResponseDTO> raffleAwardListResponseDTOS = new ArrayList<>(strategyAwardEntities.size());
            for (StrategyAwardEntity strategyAwardEntity : strategyAwardEntities) {
                //更具奖品对应的tree_id,取出对应的封锁数
                Integer awardRuleLockCount = ruleLockMap.get(strategyAwardEntity.getRuleModels());
                raffleAwardListResponseDTOS.add(RaffleAwardListResponseDTO.builder()
                        .awardId(strategyAwardEntity.getAwardId())
                        .awardTitle(strategyAwardEntity.getAwardTitle())
                        .awardSubtitle(strategyAwardEntity.getAwardSubtitle())
                        .sort(strategyAwardEntity.getSort())
                        //解锁共需多少次
                        .awardRuleLockCount(awardRuleLockCount)
                        //是否已经解锁
                        .isAwardUnlock(null == awardRuleLockCount || dayPartakeCount>= awardRuleLockCount)
                        //还剩多少次解锁
                        .waitUnLockCount(null == awardRuleLockCount || dayPartakeCount >= awardRuleLockCount ? 0:awardRuleLockCount - awardRuleLockCount)
                        .build());
            }
            Response<List<RaffleAwardListResponseDTO>> response = Response.<List<RaffleAwardListResponseDTO>>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(raffleAwardListResponseDTOS)
                    .build();


            // 返回结果
            log.info("查询抽奖奖品列表配置完成 userId:{} activityId：{} response: {}", request.getUserId(), request.getActivityId(), JSON.toJSONString(response));
            return response;
        } catch (Exception e) {
            log.error("查询抽奖奖品列表配置失败 userId:{} activityId：{}", request.getUserId(), request.getActivityId(), e);
            return Response.<List<RaffleAwardListResponseDTO>>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .build();
        }
    }

    /**
     * 随机抽奖接口
     * <a href="http://localhost:8091/api/v1/raffle/strategy/random_raffle">/api/v1/raffle/random_raffle</a>
     *
     * @param requestDTO 请求参数 {"strategyId":1000001}
     * @return 抽奖结果
     */
    @RequestMapping(value = "random_raffle", method = RequestMethod.POST)
    @Override
    public Response<RaffleResponseDTO> randomRaffle(@RequestBody RaffleRequestDTO requestDTO) {
        try {
            log.info("随机抽奖开始 strategyId: {}", requestDTO.getStrategyId());
            // 调用抽奖接口
            RaffleAwardEntity raffleAwardEntity = raffleStrategy.performRaffle(RaffleFactorEntity.builder()
                    .userId("system")
                    .strategyId(requestDTO.getStrategyId())
                    .build());
            // 封装返回结果
            Response<RaffleResponseDTO> response = Response.<RaffleResponseDTO>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(RaffleResponseDTO.builder()
                            .awardId(raffleAwardEntity.getAwardId())
                            .awardIndex(raffleAwardEntity.getSort())
                            .build())
                    .build();
            log.info("随机抽奖完成 strategyId: {} response: {}", requestDTO.getStrategyId(), JSON.toJSONString(response));
            return response;
        } catch (AppException e) {
            log.error("随机抽奖失败 strategyId：{} {}", requestDTO.getStrategyId(), e.getInfo());
            return Response.<RaffleResponseDTO>builder()
                    .code(e.getCode())
                    .info(e.getInfo())
                    .build();
        } catch (Exception e) {
            log.error("随机抽奖失败 strategyId：{}", requestDTO.getStrategyId(), e);
            return Response.<RaffleResponseDTO>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .build();
        }
    }

    @RequestMapping(value = "query_raffle_strategy_rule_weight", method = RequestMethod.POST)
    @Override
    public Response<List<RaffleStrategyRuleWeightResponseDTO>> queryRaffleStrategyRuleWeight(RaffleStrategyRuleWeightRequestDTO request) {
       // 60:102
        // 4000:102,103,104,105
        // 5000:102,103,104,105,106,107
        // 6000:102,103,104,105,106,107,108
        log.info("查询抽奖策略权重规则配置开始 userId:{} activityId：{}", request.getUserId(), request.getActivityId());
        // 1. 参数校验
        if (StringUtils.isBlank(request.getUserId()) || null == request.getActivityId()) {
            throw new AppException(ResponseCode.ILLEGAL_PARAMETER.getCode(), ResponseCode.ILLEGAL_PARAMETER.getInfo());
        }
        // 2. 查询用户抽奖总次数(结果)
        Integer userActivityAccountTotalUseCount = raffleActivityAccountQuotaService.queryRaffleActivityAccountPartakeCount(request.getActivityId(), request.getUserId());
        // 3. 查询规则
        List<RaffleStrategyRuleWeightResponseDTO> raffleStrategyRuleWeightList = new ArrayList<>();
        List<RuleWeightVO> ruleWeightVOList = raffleRule.queryAwardRuleWeightByActivityId(request.getActivityId());



        return null;
    }

}
