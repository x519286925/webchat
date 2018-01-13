package com.tencent.service.serviceImpl;

import com.baidu.aip.speech.AipSpeech;
import com.baidu.aip.speech.TtsResponse;
import com.baidu.aip.util.Util;
import com.tencent.service.BaiduService;
import com.tencent.util.KeyUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by yhn on 2018/1/13.
 */
@Service
@Slf4j
public class BaiduServiceImpl implements BaiduService{
    //设置APPID/AK/SK
    public static final String APP_ID = "10684874";
    public static final String API_KEY = "ChPPKopsdQGUUNNIoPAsojM6";
    public static final String SECRET_KEY = "51I2o1OBmSXNGFS2Q7Ip9NF4gNpZq6aa";
    @Override
    public String getVoiceLocated(String string) {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        // 初始化一个AipSpeech
        AipSpeech client = new AipSpeech(APP_ID, API_KEY, SECRET_KEY);
        // 可选：设置网络连接参数
        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(60000);
        byte[] data = synthesis(client,string);
        StringBuilder stringBuilder = new StringBuilder();
        String name = KeyUtil.genUniqueKey();
        if (data != null) {
            try {
                stringBuilder.append(attributes.getRequest().getRealPath("/"));
                stringBuilder.append(name+".mp3");
                log.warn("local={}",stringBuilder.toString());
                Util.writeBytesToFileSystem(data, stringBuilder.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return name+".mp3";
    }
    public static byte[] synthesis(AipSpeech client,String text)
    {
        // 设置可选参数
        HashMap<String, Object> options = new HashMap<String, Object>();
        options.put("spd", "5");
        options.put("pit", "5");
        options.put("per", "3");
        TtsResponse res = client.synthesis(text, "zh", 1, options);
        org.json.JSONObject result = res.getResult();    //服务器返回的内容，合成成功时为null,失败时包含error_no等信息
        byte[] data = res.getData();            //生成的音频数据
        return data;
    }

}
