package com.pjg.exam.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pjg.exam.demo.service.MemberService;
import com.pjg.exam.demo.util.Ut;
import com.pjg.exam.demo.vo.Member;
import com.pjg.exam.demo.vo.ResultData;
import com.pjg.exam.demo.vo.Rq;

@Controller
public class UsrMemberController {
	private MemberService memberService;
	
	public UsrMemberController(MemberService memberService) {
		   this.memberService = memberService;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	
	public ResultData<Member> doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNo,
			String email) {
		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "loginId(을)를 입력해주세요.");
		}
		if (Ut.empty(loginPw)) {
			return ResultData.from("F-2", "loginPw(을)를 입력해주세요.");
		}
		if (Ut.empty(name)) {
			return ResultData.from("F-3", "name(을)를 입력해주세요.");
		}
		if (Ut.empty(nickname)) {
			return ResultData.from("F-4", "nickname(을)를 입력해주세요.");
		}
		if (Ut.empty(cellphoneNo)) {
			return ResultData.from("F-5", "cellphoneNo(을)를 입력해주세요.");
		}
		if (Ut.empty(email)) {
			return ResultData.from("F-6", "email(을)를 입력해주세요.");
		}
		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNo, email);
		if (joinRd.isFail()) {
			return (ResultData) joinRd;
		}
		Member member = memberService.getMemberById(joinRd.getData1());
		return ResultData.newData(joinRd,"member", member);
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public ResultData doLogout(HttpSession httpSession) {
		boolean isLogined = false;
		
		if (httpSession.getAttribute("loginedMemberId") == null) {
			isLogined = true;
		}
		
		if (isLogined) {
			return ResultData.from("S-1", "이미 로그아웃 상태입니다.");
		}
		
		httpSession.removeAttribute("loginedMemberId");
		
		return ResultData.from("S-2", "로그아웃 되었습니다.");
	}
	
	
	@RequestMapping("/usr/member/login")
	public String showLogin(HttpSession httpSession){
		return "usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw) {
		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("이미 로그인되었습니다.");
		}

		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("loginId(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("loginPw(을)를 입력해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("존재하지 않은 로그인아이디 입니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}

		rq.login(member);

		return Ut.jsReplace(Ut.f("%s님 환영합니다.", member.getNickname()), "/");
	}
}