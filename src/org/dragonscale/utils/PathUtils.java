package org.dragonscale.utils;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.ServletContext;

import org.dragonscale.webase.utils.LogUtils;
import org.dragonscale.webase.utils.StringUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * @Author Aliqi
 * @Date 2016年8月1日
 **/
public final class PathUtils {

	public static final String slash = "/";

	public static String combine(String src, String value) {
		if (src == null)
			return value;
		if (value == null)
			return src;
		src = StringUtils.trimEnd(src, slash);
		value = StringUtils.trimStart(value, slash);
		return src + slash + value;
	}

	public static void createDirectory(String path) {
		File file = new File(path);
		file.mkdirs();
	}

	public static String upload(ServletContext context, MultipartFile file, String relativeFolder) throws Exception {
		String name = file.getOriginalFilename();
		String rootFolder = context.getRealPath("/");
		String dir = combine(rootFolder, relativeFolder);
		String fileName = uploadFile(file, dir, name);
		String url = combine(relativeFolder, fileName);
		return combine(context.getContextPath(), url);
	}

	public static String uploadFile(MultipartFile file, String folder, String name) throws Exception {
		String fileName = getPath(folder, name);
		String path = combine(folder, fileName);
		createDirectory(folder);
		FileOutputStream out = new FileOutputStream(path);
		out.write(file.getBytes());
		out.flush();
		out.close();
		return fileName;
	}

	public static boolean deleteFile(ServletContext context, String imgPath) {
		String path = context.getRealPath("");
		String proName = context.getContextPath();
		proName = proName.replace("/", "\\");
		String url = PathUtils.combine(path.replace(proName, ""), imgPath);
		boolean flag = false;
		File file = new File(url);
		if (file.isFile() && file.exists()) {
			flag = file.delete();
		}
		return flag;
	}

	public static String getPath(String folder, String name) {
		String path = "";
		String tempName = name;
		LogUtils.info("path:" + path);
		LogUtils.info("name:" + name);

		int i = 0;
		boolean have = false;
		do {
			path = combine(folder, tempName);
			File checkFile = new File(path);
			if (checkFile.isFile() && checkFile.exists()) {
				++i;
				String[] nameArray = name.split("\\.");
				tempName = nameArray[0] + "(" + i + ")." + nameArray[1];
				have = true;
			} else
				have = false;
		} while (have);
		return tempName;
	}
}
