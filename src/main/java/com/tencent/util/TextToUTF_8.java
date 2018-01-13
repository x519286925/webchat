package com.tencent.util;

import java.io.UnsupportedEncodingException;

/**
 * Created by yhn on 2018/1/12.
 */
public class TextToUTF_8 {
    public static String getUtf8(String text){
        StringBuilder output = new StringBuilder();
        for (int i = 0; i < text.length(); i++)
        {
            output.append("\\u" +Integer.toString(text.charAt(i), 16));
        }
        return output.toString();
    }
}
