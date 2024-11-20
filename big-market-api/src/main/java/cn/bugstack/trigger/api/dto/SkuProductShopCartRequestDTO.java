package cn.bugstack.trigger.api.dto;

import lombok.Data;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 商品购物车请求对象
 * @create 2024-06-15 08:03
 */
@Data
public class SkuProductShopCartRequestDTO {

    /**
     * 用户ID
     */
    private String userId;
    /**
     * sku 商品
     */
    private Long sku;

}
