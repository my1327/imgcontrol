package org.dragonscale.utils;

/**
* @Author Gree
* @Date 2016年7月26日
**/

public interface AppCode {
	public static final int ok = 0;
	public static final int error = -1;

	public static final int user_not_login = -2;
	public static final int user_logined = -3;
	public static final int user_login_failed = -4;
	public static final int user_no_privilege = -5;
	public static final int db_error = -6;
	public static final int same_name_in_db = -7;
	public static final int no_name_specified = -8;
	public static final int invalid_data = -9;
	public static final int non_exist = -10;
	public static final int no_password_specified = -11;
	public static final int invalid_param = -12;
	public static final int no_param_specified = -13;
	public static final int file_exceeds = -14;
	
	public static final int order_remove = 1;
	public static final int order_pay = 2;
	public static final int order_send= 3;
	public static final int order_receive = 4;
	public static final int order_over = 5;
}
