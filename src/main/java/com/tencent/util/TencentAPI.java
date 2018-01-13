package com.tencent.util;
/**
 * 腾讯AI应用常量存放类
 * @author 小帅丶
 * 官网地址  https://ai.qq.com/cgi-bin/console_usercenter#/app-management/app-list
 */
public class TencentAPI {
	//自己的APPID
	public static final Integer APP_ID_AI = 1106497877;
	//自己的APPKEY
	public static final String APP_KEY_AI = "QZ9UTeKlkBMz8p6n";
	public static final String PERSON_ID = "https://api.ai.qq.com/fcgi-bin/ocr/ocr_idcardocr";  //身份证识别
	public static final String PHOTO_SPEAK = "https://api.ai.qq.com/fcgi-bin/vision/vision_imgtotext"; //看图说话
	public static final String SCENE_RECOGNITION  = "https://api.ai.qq.com/fcgi-bin/vision/vision_scener"; //场景识别：对图行进行场景识别，快速找出图片中包含的场景信息
	public static final String OBJECT_RECOGNITION = "https://api.ai.qq.com/fcgi-bin/vision/vision_objectr"; //物体识别:对图行进行物体识别，快速找出图片中包含的物体信息
	public static final String IMAGE_LABEL = "https://api.ai.qq.com/fcgi-bin/image/image_tag"; //图像标签识别:识别一个图像的标签信息,对图像分类。
	public static final String FACE_MERGE = "https://api.ai.qq.com/fcgi-bin/ptu/ptu_facemerge";  //人脸融合
	public static final String PHOTOFORTRANSLATE="https://api.ai.qq.com/fcgi-bin/nlp/nlp_imagetranslate";  //图片翻译
	public static final String AII_ASR = "https://api.ai.qq.com/fcgi-bin/aai/aai_asr";  //语音识别
	public static final String TEXTCHAT ="https://api.ai.qq.com/fcgi-bin/nlp/nlp_textchat";//智能闲聊
	public static final String VOICEAI = "https://api.ai.qq.com/fcgi-bin/aai/aai_tts"; //语音合成
}
