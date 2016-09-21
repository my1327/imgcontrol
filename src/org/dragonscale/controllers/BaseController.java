package org.dragonscale.controllers;

import org.dragonscale.models.JsonMessage;
import org.dragonscale.webase.utils.LogUtils;

import com.alibaba.fastjson.JSON;

/**
 * @Author Aliqi
 * @Date 2016年6月12日
 **/

public abstract class BaseController {

	public static void info(String logger, String text) {
		LogUtils.info(logger, text);
	}

	public static String toJson(Object obj) {
		return JSON.toJSONString(obj);
	}

	public static JsonMessage ok() {
		return ok(null);
	}

	public static JsonMessage ok(String content) {
		return JsonMessage.ok(content);
	}

	public static JsonMessage error() {
		return error(null);
	}

	public static JsonMessage error(String content) {
		return JsonMessage.error(content);
	}

	public static JsonMessage code(int code) {
		return JsonMessage.code(code);
	}
}
