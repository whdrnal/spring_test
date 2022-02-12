package com.pjg.exam.demo.service;

import org.springframework.stereotype.Service;

import com.pjg.exam.demo.repository.MemberRepository;
import com.pjg.exam.demo.util.Ut;
import com.pjg.exam.demo.vo.Member;
import com.pjg.exam.demo.vo.ResultData;

@Service
public class MemberService {
	private MemberRepository memberRepository;
	
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public ResultData join(String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {
		Member oldMember = getMemberByLoginId(loginId);

		if (oldMember != null) {
			return ResultData.from("F-7", Ut.f("해당 로그인 아이디(%s)는 이미 사용중입니다.", loginId));
		}
		
		oldMember = getMemberByNameAndEmail(name, email);
		
		if (oldMember != null) {
			return ResultData.from("F-8", Ut.f("해당 이름(%s) 과 이메일(%s)은 이미 사용중입니다."));
		}
 
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNo, email);
		int id = memberRepository.getLastInsertId();
		
		return ResultData.from("S-1", "회원가입이 완료되었습니다.", id);
	}
	
	private Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	private Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}
	
	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
}