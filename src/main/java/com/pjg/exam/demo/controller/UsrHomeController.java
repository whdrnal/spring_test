
package com.pjg.exam.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrHomeController {
	@RequestMapping("/usr/home/main")
	public String showMain() {
		return "usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
	
	
	//이밑 코드들은 ajax 연습 코드 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 입니다.
	@RequestMapping("/usr/test/doPlus")
	@ResponseBody
	String showPlus(int num1, int num2) {
		
		String msg = "더하기에 성공하였습니다.";
		int rs = num1 + num2;
		
		return rs + "/" + msg + "/S-1";
	}
	
	
	@RequestMapping("/usr/test/plus")
	String plus() {
		return "usr/test/plus";
	}
	
	@RequestMapping("/usr/test/doPlusJson")
	@ResponseBody
	Map plusJson(int num1, int num2) {
		Map rs = new HashMap<String, Object>();
		
		rs.put("rs", num1 + num2);
		rs.put("msg", "더하기에성공");
		rs.put("code", "S-1");
		
		return rs;
	}
}