package org.dragonscale.controllers;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.dragonscale.dao.ImageDao;
import org.dragonscale.models.Image;
import org.dragonscale.utils.AppCode;
import org.dragonscale.utils.Const;
import org.dragonscale.utils.PathUtils;
import org.dragonscale.webase.utils.AppConfig;
import org.dragonscale.webase.utils.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
* @Author Gree
* @Date 2016年8月5日
**/

@Controller
@RequestMapping("/image")
public class ImageController extends BaseController{

	public static final String uploadImageDir = AppConfig.current.config.getString(Const.uploadImageDir);
	public static final String supplyImageDir = PathUtils.combine(uploadImageDir, Const.supplier);
	ImageDao dao = new ImageDao();
	
	@ResponseBody
	@PostMapping("/upload" + Const.serviceSuffix)//CommonsMultipartFile
	public Object uploadImage(HttpSession session, HttpServletRequest request, MultipartFile file) throws Exception {
		String dir = PathUtils.combine(supplyImageDir, "my");
		String imgUrl = PathUtils.upload(request.getServletContext(), file, dir);
		System.out.println("imgurl:" + imgUrl);
		Object obj = add(session, imgUrl);
		return obj;
	}
	
	@ResponseBody
	@PostMapping("/remove" + Const.serviceSuffix)
	public Object remove(HttpServletRequest request, String id) {
		if (StringUtils.isEmpty(id))
			return code(AppCode.no_name_specified);
		int i = dao.remove(request.getServletContext(),id);
		return code(i);
	}
	
	public Object add(HttpSession session, String url) {
		String userId = "my";
		Date date = new Date();
		Image image = new Image();
		image.setId(StringUtils.uuid());
		image.setUrl(url);
		image.setUser_id(userId);
		image.setTime(date);
		return code(dao.add(image));
	}
	
	@ResponseBody
	@GetMapping("/get" + Const.serviceSuffix)
	public Object getImageByUserId(HttpSession session, Integer page, Integer size) {
		String userId = "my";
		if (size == null)
			return dao.listAll();
		if (page == null)
			page = 0;
		int begin = page * size;
		if (begin < 0)
			begin = 0;
		return dao.list(userId, begin, size);
	}	
	
	@ResponseBody
	@GetMapping("/count")
	public int count() {
		String userId = "my";
		return dao.count(userId);
	}
}
