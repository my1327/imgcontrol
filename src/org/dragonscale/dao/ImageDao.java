package org.dragonscale.dao;

import java.util.List;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.SqlSession;
import org.dragonscale.mappers.ImageMapper;
import org.dragonscale.models.Image;
import org.dragonscale.utils.AppCode;
import org.dragonscale.utils.PathUtils;
import org.dragonscale.webase.utils.LogUtils;

/**
 * @Author Gree
 * @Date 2016年8月9日
 **/

public class ImageDao extends BaseDao {
	private static Class<ImageMapper> type = ImageMapper.class;

	public List<Image> list(String userId, int begin, int size) {
		if (begin < 0)
			begin = 0;
		return getMapper(type).list(userId, begin, size);
	}

	public List<Image> listAll() {
		return getMapper(type).listAll();
	}

	public boolean has(String id) {
		return getMapper(type).hasId(id);
	}

	public Image get(String id) {
		return getMapper(type).getById(id);
	}

	public int add(Image image) {
		if (image == null)
			return AppCode.invalid_param;
		SqlSession session = null;
		try {
			getMapper(type).add(image);
			return AppCode.ok;
		} catch (Exception e) {
			LogUtils.printStackTrace(e);
			LogUtils.info(getClass().getName(), e.getMessage());
			return AppCode.db_error;
		} finally {
			if (session != null)
				session.close();
		}
	}

	public int remove(ServletContext context, String id) {
		SqlSession session = null;
		try {
			if (has(id)) {
				if(PathUtils.deleteFile(context, get(id).getUrl()))
					getMapper(type).remove(id);
				return AppCode.ok;
			}
		} catch (Exception e) {
			LogUtils.printStackTrace(e);
			LogUtils.info(getClass().getName(), e.getMessage());
			return AppCode.db_error;
		} finally {
			if (session != null)
				session.close();
		}
		return AppCode.non_exist;
	}

	public int count(String userId) {
		return getMapper(type).getCountByUserId(userId);
	}
}
