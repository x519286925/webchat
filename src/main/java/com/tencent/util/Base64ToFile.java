package com.tencent.util;
import sun.misc.BASE64Decoder;

import java.io.FileOutputStream;
/**
 * Created by yhn on 2018/1/13.
 */
public class Base64ToFile {
    public static void decoderBase64File2(String voiceStr, String targetPath) throws Exception { // 对字节数组字符串进行Base64解码并生成图片
        byte[] buffer = new BASE64Decoder().decodeBuffer(voiceStr);
        FileOutputStream out = new FileOutputStream(targetPath);
        out.write(buffer);
        out.close();
    }
}
