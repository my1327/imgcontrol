package org.dragonscale.models;

import org.dragonscale.utils.AppCode;
import org.dragonscale.utils.AppCodeContent;

/**
* @Author Gree
* @Date 2016年8月9日
**/

public class JsonMessage {
	public int code;
	public String content;

	public JsonMessage() {
	}

	public JsonMessage(int code, String content) {
		this.code = code;
		this.content = content;
	}

	public static JsonMessage code(int code) {
		return new JsonMessage(code, AppCodeContent.get(code));
	}

	public static JsonMessage error(String content) {
		return new JsonMessage(AppCode.error, content);
	}

	public static JsonMessage ok(String content) {
		return new JsonMessage(AppCode.ok, content);
	}
}
