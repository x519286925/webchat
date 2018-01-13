package com.VO;

import lombok.Data;

/**
 * Created by yhn on 2017/10/29.
 */
@Data
public class WxJsVO {
    private String appId;
    private String nonceStr;
    private String timestamp;
    private String url;
    private String signature;
}
