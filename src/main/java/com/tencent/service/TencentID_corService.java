package com.tencent.service;

/**
 * Created by yhn on 2017/12/6.
 */
public interface TencentID_corService {
    String getPhoto_Speak(String url, String method)throws Exception; //看图说话
    String getVoiceText(String url,String method)throws Exception;  //语音识别
    String getTextChat(String text)throws Exception;  //智能闲聊
    String getTextToVoice(String text)throws Exception;  //语音合成
}
