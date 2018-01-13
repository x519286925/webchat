package com.tencent.enums;

import lombok.Getter;

/**
 * Created by yhn on 2017/8/1.
 */
@Getter
public enum ResultEnum {
    PERSON_ID(0,"身份证识别"), //身份证识别
    PHOTO_SPEAK(1,"看图说话"), //看图说话
    SCENE_RECOGNITION(2,"场景识别"), //场景识别：对图行进行场景识别，快速找出图片中包含的场景信息
    OBJECT_RECOGNITION(3,"物体识别"), //物体识别:对图行进行物体识别，快速找出图片中包含的物体信息
    IMAGE_LABEL(4,"图像标签识别") ,  //图像标签识别:识别一个图像的标签信息,对图像分类。
    FACE_MERGE(5,"人脸融合"),
    PHOTOFORTRANSLATE(6,"图片翻译")
    ;
    private Integer code;
    private String message;
    ResultEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

}
