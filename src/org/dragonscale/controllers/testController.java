package org.dragonscale.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/test")
public class testController extends BaseController {

	@ResponseBody
	@GetMapping("/get")
	public String getString(int id, String name) {
		System.out.println(id + "   " + name);
		return "Hello Java";
	}

	@ResponseBody
	@PostMapping("/list")
	public String getList(int id, String name) {
		System.out.println(id + "   " + name);
		return "Hello Java";
	}
}
