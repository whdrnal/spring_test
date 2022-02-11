
package com.pjg.exam.demo.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

public class UsrHomeController {
	@RequestMapping("/usr/home/main")
	@ResponseBody
	public String getString() {
		return "안녕하세요.";
	}
}