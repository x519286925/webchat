package com.tencent.util;

/**
 * Created by yhn on 2017/12/6.
 */
public class UrlMethodUtil {
    public static byte[] local2byte(String url)throws Exception{  //由本地路径得到byte
        byte [] imageData = FileUtil.readFileByBytes(url);
        return imageData;
    }
    public static byte[] url2byte(String url)throws Exception {  //由url路径得到byte
        byte [] imageData =  IoUtil.getImageFromNetByUrl(url);
        return imageData;
    }

}
