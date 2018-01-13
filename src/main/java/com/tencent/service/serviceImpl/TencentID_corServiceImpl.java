package com.tencent.service.serviceImpl;
import com.tencent.enums.MethodEnum;
import com.tencent.service.TencentID_corService;
import com.tencent.sign.TencentAISign;
import com.tencent.sign.TencentAISignSort;
import com.tencent.util.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.beans.Encoder;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by yhn on 2017/12/6.
 */
@Service
@Scope("prototype")
@Slf4j
public class TencentID_corServiceImpl implements TencentID_corService{
    public String getPhoto_Speak(String url,String method) throws Exception {
        //时间戳
        String time_stamp = System.currentTimeMillis()/1000+"";
        byte[] imageData;
        if(method.equals(MethodEnum.url2byte.getMessage())) {
            imageData = UrlMethodUtil.url2byte(url);
        }
        else{
            imageData = UrlMethodUtil.local2byte(url);
        }
        //图片的base64编码数据
        String img64 = Base64Util.encode(imageData);
        //随机字符串
        String nonce_str = TencentAISign.getRandomString(10);
        Map<String,String> person_Id_body = new HashMap<>();
        person_Id_body.put("app_id", String.valueOf(TencentAPI.APP_ID_AI));
        person_Id_body.put("time_stamp",time_stamp);
        person_Id_body.put("nonce_str", nonce_str);
        person_Id_body.put("image", img64);
        person_Id_body.put("session_id", KeyUtil.genUniqueKey());
        String sign = TencentAISignSort.getSignature(person_Id_body);
        person_Id_body.put("sign", sign);
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/x-www-form-urlencoded");
        HttpResponse responseBD = HttpsUtil4Tencent.doPostTencentAI(TencentAPI.PHOTO_SPEAK, headers, person_Id_body);
        String json = EntityUtils.toString(responseBD.getEntity());
        return json;
    }

    @Override
    public String getVoiceText(String url, String method) throws Exception {
        //时间戳
        String time_stamp = System.currentTimeMillis()/1000+"";
        byte[] voiceData;
        if(method.equals(MethodEnum.url2byte.getMessage())) {
            voiceData = UrlMethodUtil.url2byte(url);
        }
        else{
            voiceData = UrlMethodUtil.local2byte(url);
        }
        //图片的base64编码数据
        String voiceData64 = Base64Util.encode(voiceData);
        //随机字符串
        String nonce_str = TencentAISign.getRandomString(10);
        Map<String,String> person_Id_body = new HashMap<>();
        person_Id_body.put("app_id", String.valueOf(TencentAPI.APP_ID_AI));
        person_Id_body.put("time_stamp",time_stamp);
        person_Id_body.put("nonce_str", nonce_str);
        person_Id_body.put("format", "3");
        person_Id_body.put("speech", voiceData64);
        String sign = TencentAISignSort.getSignature(person_Id_body);
        person_Id_body.put("sign", sign);
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/x-www-form-urlencoded");
        HttpResponse responseBD = HttpsUtil4Tencent.doPostTencentAI(TencentAPI.AII_ASR, headers, person_Id_body);
        String json = EntityUtils.toString(responseBD.getEntity());
        return json;
    }

    @Override
    public String getTextToVoice(String text) throws Exception {
        //时间戳
        String time_stamp = System.currentTimeMillis()/1000+"";
        //随机字符串
        String nonce_str = TencentAISign.getRandomString(10);
        Map<String,String> person_Id_body = new HashMap<>();
        person_Id_body.put("app_id", String.valueOf(TencentAPI.APP_ID_AI));
        person_Id_body.put("time_stamp",time_stamp);
        person_Id_body.put("nonce_str", nonce_str);
        person_Id_body.put("speaker", "1");
        person_Id_body.put("format", "2");
        person_Id_body.put("volume", "8");
        person_Id_body.put("speed", "100");
        person_Id_body.put("text", text);
        person_Id_body.put("aht","0");
        person_Id_body.put("apc","58");
        String sign = TencentAISignSort.getSignature(person_Id_body);
        person_Id_body.put("sign", sign);
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/x-www-form-urlencoded");
        HttpResponse responseBD = HttpsUtil4Tencent.doPostTencentAI(TencentAPI.VOICEAI, headers, person_Id_body);
        String json = EntityUtils.toString(responseBD.getEntity());
        return json;
    }

    @Override
    public String getTextChat(String text) throws Exception {
        //时间戳
        String time_stamp = System.currentTimeMillis()/1000+"";
        //随机字符串
        String nonce_str = TencentAISign.getRandomString(10);
        Map<String,String> person_Id_body = new HashMap<>();
        person_Id_body.put("app_id", String.valueOf(TencentAPI.APP_ID_AI));
        person_Id_body.put("time_stamp",time_stamp);
        person_Id_body.put("nonce_str", nonce_str);
        person_Id_body.put("session", KeyUtil.genUniqueKey());
        person_Id_body.put("question", text);
        String sign = TencentAISignSort.getSignature(person_Id_body);
        person_Id_body.put("sign", sign);
        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/x-www-form-urlencoded");
        HttpResponse responseBD = HttpsUtil4Tencent.doPostTencentAI(TencentAPI.TEXTCHAT, headers, person_Id_body);
        String json = EntityUtils.toString(responseBD.getEntity());
        return json;
    }

}
