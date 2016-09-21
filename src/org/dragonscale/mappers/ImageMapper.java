package org.dragonscale.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Options.FlushCachePolicy;
import org.dragonscale.models.Image;

/**
* @Author Gree
* @Date 2016年8月9日
**/

public interface ImageMapper {
	@Insert("INSERT into images(id, url, user_id, time)"
			+ "values(#{id}, #{url}, #{user_id}, #{time})")
	@Options(flushCache = FlushCachePolicy.TRUE)
	int add(Image items);

	@Select("SELECT * FROM images where user_id = #{userId} order by time desc limit #{start}, #{size}")
	List<Image> list(@Param("userId") String  userId, @Param("start") int start, @Param("size") int size);

	@Select("SELECT * FROM images order by time desc")
	List<Image> listAll();

	@Delete("DELETE FROM images WHERE id = #{id}")
	@Options(flushCache = FlushCachePolicy.TRUE)
	void remove(@Param("id") String id);

	@Select("SELECT COUNT(id) > 0 FROM images WHERE id = #{id}")
	boolean hasId(@Param("id") String id);
	
	@Select("SELECT COUNT(id) > 0 FROM images WHERE url = #{url}")
	boolean hasUrl(@Param("url") String url);
	
	@Select("SELECT * FROM images WHERE id = #{id}")
	Image getById(@Param("id") String id);

	@Select("SELECT COUNT(id) FROM images")
	int count();
	
	@Select("SELECT COUNT(id) FROM images where user_id = #{user_id}")
	int getCountByUserId(@Param("user_id") String user_id);
}
