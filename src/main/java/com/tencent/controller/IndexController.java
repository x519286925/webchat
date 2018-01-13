package com.tencent.controller;

import com.VO.WxJsVO;
import com.tencent.config.UrlConfig;
import com.tencent.enums.MethodEnum;
import com.tencent.service.BaiduService;
import com.tencent.service.TencentID_corService;
import com.tencent.util.TextToUTF_8;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.bean.WxJsapiSignature;
import me.chanjar.weixin.mp.api.WxMpService;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.util.Map;

/**
 * Created by yhn on 2017/12/7.
 */
@RestController
@Slf4j
public class IndexController {
    @Autowired
    private TencentID_corService tencentID_corService;
    @Autowired
    private UrlConfig urlConfig;
    @Autowired
    private WxMpService wxMpService; //已配置完成
    @Autowired
    private BaiduService baiduService;
    @GetMapping("/index")
    public ModelAndView test(Map<String,Object> map)throws Exception {
        //        //js jdk
        String testUrlgetAccessToken = urlConfig.getUrl()+"/index";
        log.info("【查看是否获取到accessToken】,accessToken={}",wxMpService.getAccessToken());  //获得accessToken;
        String ticket =  wxMpService.getJsapiTicket();
        log.info("【查看是否获取到ticket】,ticket={}",ticket);  //获得accessToken;
        WxJsapiSignature wxJsapiSignature = wxMpService.createJsapiSignature(testUrlgetAccessToken);
        log.info("【获得参数为:】appid={},nonceStr={},signature={},timestamp={},url={}",wxJsapiSignature.getAppId(),wxJsapiSignature.getNonceStr(),wxJsapiSignature.getSignature(),wxJsapiSignature.getTimestamp(),wxJsapiSignature.getUrl());
        WxJsVO wxJsVO = new WxJsVO();
        BeanUtils.copyProperties(wxJsapiSignature,wxJsVO);
        wxJsVO.setTimestamp(String.valueOf(wxJsapiSignature.getTimestamp()));
        log.info("【copy参数为:】appid={},nonceStr={},signature={},timestamp={},url={}",wxJsVO.getAppId(),wxJsVO.getNonceStr(),wxJsVO.getSignature(),wxJsVO.getTimestamp(),wxJsVO.getUrl());
        map.put("wxJsVO",wxJsVO);
        map.put("projectUrl",urlConfig.getUrl());
        return new ModelAndView("page/chat",map);
    }
    @PostMapping("/uploadVoice")  //上传录音
    public String uploadVoice(@RequestParam("media_id") String media_id) throws Exception{
        File file = wxMpService.getMaterialService().mediaDownload(media_id);//本地路径
        log.info("file={}",file.toString());
        String text =  tencentID_corService.getVoiceText(file.toString(), MethodEnum.local2byte.getMessage());
        return text;
    }
    @PostMapping("/uploadText")  //上传文本
    public String uploadText(@RequestParam("text") String text)throws Exception{
        String str =  tencentID_corService.getTextChat(TextToUTF_8.getUtf8(text));
//        String located = baiduService.getVoiceLocated(str);
//        log.info("录音地址："+located);
        return str;
    }
    @PostMapping("/getVoice")  //生成录音
    public String getVoice(@RequestParam("text") String text)throws Exception{
        String located = baiduService.getVoiceLocated(text);
        log.info("录音地址："+urlConfig.getUrl()+"/"+located);
        return located;
    }
}
