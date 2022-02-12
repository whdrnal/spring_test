package com.pjg.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pjg.exam.demo.service.MemberService;
import com.pjg.exam.demo.util.Ut;
import com.pjg.exam.demo.vo.Member;
import com.pjg.exam.demo.vo.ResultData;

@Controller
public class UsrMemberController {
	private MemberService memberService;

	public UsrMemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNo,
			String email) {
		if (Ut.empty(loginId)) {
			return ResultData.from("S-1", "loginId(을)를 입력해주세요.", loginId);
		}

		if (Ut.empty(loginPw)) {
			return ResultData.from("S-2", "loginPw(을)를 입력해주세요.", loginPw);
		}

		if (Ut.empty(name)) {
			return ResultData.from("S-3", "name(을)를 입력해주세요.", name);
		}

		if (Ut.empty(nickname)) {
			return ResultData.from("S-4", "nickname(을)를 입력해주세요.", nickname);
		}

		if (Ut.empty(cellphoneNo)) {
			return ResultData.from("S-5", "cellphoneNo(을)를 입력해주세요.", cellphoneNo);
		}

		if (Ut.empty(email)) {
			return ResultData.from("S-6", "email(을)를 입력해주세요.", email);
		}

		ResultData joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNo, email);

		if (joinRd.isFail()) {
			return joinRd;
		}

		Member member = memberService.getMemberById((int) joinRd.getData1());
		return ResultData.newData(joinRd, member);
	}
}