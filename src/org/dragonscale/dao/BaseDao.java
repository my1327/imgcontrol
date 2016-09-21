package org.dragonscale.dao;

import org.apache.ibatis.session.SqlSession;
import org.dragonscale.webase.utils.MybatisUtils;

/**
* @Author Gree
* @Date 2016年8月9日
**/

public abstract class BaseDao {
	public static synchronized SqlSession openDataSession() {
		return MybatisUtils.openSession();
	}

	public static synchronized <T> T getMapper(Class<T> type) {
		return MybatisUtils.openManagedSession().getMapper(type);
	}
}
