package com.tencent.util;

import net.sf.json.JSONObject;

/**
 * Created by yhn on 2017/12/2.
 */
public class ObjectToJSON {
    public static String getJSON(Object object) {
        JSONObject jsonObject = new JSONObject();
        return jsonObject.fromObject(object).toString();
    }
}
