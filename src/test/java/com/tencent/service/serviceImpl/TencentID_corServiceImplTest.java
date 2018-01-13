package com.tencent.service.serviceImpl;
import com.baidu.aip.speech.AipSpeech;
import com.baidu.aip.speech.TtsResponse;
import com.baidu.aip.util.Util;
import com.tencent.util.Base64ToFile;
import com.tencent.util.KeyUtil;
import com.tencent.util.TextToUTF_8;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;

/**
 * Created by yhn on 2018/1/12.
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class TencentID_corServiceImplTest {
    //设置APPID/AK/SK
    public static final String APP_ID = "10684874";
    public static final String API_KEY = "ChPPKopsdQGUUNNIoPAsojM6";
    public static final String SECRET_KEY = "51I2o1OBmSXNGFS2Q7Ip9NF4gNpZq6aa";

    @Autowired
    private TencentID_corServiceImpl tencentID_corService;
    @Test
    public void getPhoto_Speak() throws Exception {
        // 初始化一个AipSpeech
        AipSpeech client = new AipSpeech(APP_ID, API_KEY, SECRET_KEY);
        // 可选：设置网络连接参数
        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(60000);
        byte[] data = synthesis(client);
        if (data != null) {
            try {
                Util.writeBytesToFileSystem(data, "D://output.mp3");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public static byte[] synthesis(AipSpeech client)
    {
        // 设置可选参数
        HashMap<String, Object> options = new HashMap<String, Object>();
        options.put("spd", "5");
        options.put("pit", "5");
        options.put("per", "3");
        TtsResponse res = client.synthesis("我就是可爱的楠尼玛，有什么想和我说的", "zh", 1, options);
        org.json.JSONObject result = res.getResult();    //服务器返回的内容，合成成功时为null,失败时包含error_no等信息
        byte[] data = res.getData();            //生成的音频数据
        return data;
    }
}