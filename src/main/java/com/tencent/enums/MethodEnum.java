package com.tencent.enums;

import lombok.Getter;

/**
 * Created by yhn on 2017/8/1.
 */
@Getter
public enum MethodEnum {
    local2byte(0,"本地路径"), //身份证识别
    url2byte(1,"url路径"), //看图说话
    ;
    private Integer code;
    private String message;
    MethodEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

}
