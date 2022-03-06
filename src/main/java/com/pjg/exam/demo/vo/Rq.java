package com.pjg.exam.demo.vo;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.pjg.exam.demo.service.MemberService;
import com.pjg.exam.demo.util.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)

public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;

	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	private Map<String, String> paramMap;

	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {
		this.req = req;
		this.resp = resp;

		paramMap = Ut.getParamMap(req);

		this.session = req.getSession();

		boolean isLogined = false; // 로그인 여부만 알수있다.
		int loginedMemberId = 0; // loginMemberId 많이 썼던 이유: 로그인 여부 와 어떤 회원이 들어왔는지 알기위해서.

		Member loginedMember = null;
		if (session.getAttribute("loginedMemberId") != null) {
			// 로그인한 고객이 존재한다면 아래 코드를 실행시켜라.
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;

		this.req.setAttribute("rq", this);
	}

	public void printReplaceJs(String msg, String url) {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplace(msg, url));
	}

	public void printHistoryBackJs(String msg) {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsHistoryBack(msg));
	}

	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public boolean isNotLogined() {
		return !isLogined;
	}

	public void println(String str) {
		print(str + "\n");
	}

	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	}

	public String historyBackJsOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "common/js";
	}

	public String jsHistoryBack(String msg) {
		return Ut.jsHistoryBack(msg);
	}

	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}

	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		if (queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}

	public String getEncodedCurrentUri() {
		return Ut.getUriEncoded(getCurrentUri());
	}

	// 이 메서드는 Rq 객체가 자연스럽게 생성되도록 유도하는 역할을 한다.
	// 지우면 안되고,
	// 편의를 위해 BeforeActionInterceptor 에서 꼭 호출해줘야 한다.
	public void initOnBeforeActionInterceptor() {

	}

	public String getLoginUri() {
		return "../member/login?afterLoginUri=" + getAfterLoginUri();
	}

	public String getLogoutUri() {
		String requestUri = req.getRequestURI();

		// 메인으로 가고싶다면 활성화 / 현재 있던 페이지로 이동
		/*
		 * switch (requestUri) { case "/usr/article/write": return ""; }
		 */

		return "../member/doLogout?afterLogoutUri=" + getAfterLogoutUri();
	}

	public String getAfterLoginUri() {
		String requestUri = req.getRequestURI();

		// 로그인 후 다시 돌아가면 안되는 페이지 URL 들
		switch (requestUri) {
		case "/usr/member/login":
		case "/usr/member/join":
		case "/usr/member/findLoginId":
		case "/usr/member/findLoginPw":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLoginUri", ""));
		}

		return getEncodedCurrentUri();
	}

	public String getAfterLogoutUri() {
		return getEncodedCurrentUri();
	}
	
	
	// 파라미터 값을 가지고 가야 뒤로가기 가능 , NOT 임프티 사용 ( 무조껀 값이 있을때만 이동가능 )
	// 기본 임프티 값이 없어도 이동가능 
	public String getArticleDetailUriFromArticleList(Article article) {
		return "../article/detail?id=" + article.getId() + "&listUri=" + getEncodedCurrentUri();
	}
}