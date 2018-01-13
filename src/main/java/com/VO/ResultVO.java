package com.VO;

import lombok.Data;

/**
 * http请求返回的最外层对象
 * Created by yhn on 2017/7/29.
 */
@Data
public class ResultVO{
    private Integer code;  //错误码来使用
    private String msg;    //提示信息
}
