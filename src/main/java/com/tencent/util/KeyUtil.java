package com.tencent.util;

import java.util.Random;

/**
 * Created by yhn on 2017/8/1.
 */
public class KeyUtil {
    /*
            生成唯一的主键
            格式：时间+随机数；
     */
    public  static synchronized String genUniqueKey(){
        Random random = new Random();
        Integer a = random.nextInt(900000)+100000;
        return  System.currentTimeMillis()+String.valueOf(a);
    }
}
