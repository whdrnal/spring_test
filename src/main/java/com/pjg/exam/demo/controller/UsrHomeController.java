package com.pjg.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class UsrHomeController {
	@RequestMapping("usr/home/getString")
	@ResponseBody
	public String getString() {
		return "HI";
	}
}



