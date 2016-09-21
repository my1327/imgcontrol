package org.dragonscale.utils;

import java.util.HashMap;

/**
* @Author Gree
* @Date 2016年7月26日
**/

public final class AppCodeContent {
	private static HashMap<Integer, String> map = new HashMap<>();

	static {
		map.put(AppCode.ok, "成功");
		map.put(AppCode.user_not_login, "用户未登录。");
		map.put(AppCode.user_logined, "用户已登录。");
		map.put(AppCode.user_login_failed, "用户名或密码错误！");
		map.put(AppCode.user_no_privilege, "用户没有权限！");
		map.put(AppCode.db_error, "数据库异常！");
		map.put(AppCode.same_name_in_db, "数据库中存在相同的名称。");
		map.put(AppCode.no_name_specified, "名称未设置。");
		map.put(AppCode.invalid_data, "非法数据！");
		map.put(AppCode.non_exist, "数据不存在！");
		map.put(AppCode.no_password_specified, "密码未设置！");
		map.put(AppCode.invalid_param, "非法参数！");
		map.put(AppCode.no_param_specified, "参数未设置！");
		map.put(AppCode.file_exceeds, "文件大小超出限制！");

		map.put(AppCode.order_remove, "交易关闭");
		map.put(AppCode.order_pay, "待付款");
		map.put(AppCode.order_send, "待发货");
		map.put(AppCode.order_receive, "待收货");
		map.put(AppCode.order_over, "交易完成");
	}

	public static String get(int code) {
		return map.get(code);
	}
}
