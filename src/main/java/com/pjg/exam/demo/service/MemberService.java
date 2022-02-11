package com.pjg.exam.demo.service;

import org.springframework.stereotype.Service;

import com.pjg.exam.demo.repository.MemberRepository;
import com.pjg.exam.demo.vo.Member;

@Service
public class MemberService {
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public int join(String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNo, email);
		return memberRepository.getLastInsertId();
	}

	public Member getMemberById(int id) {

		return memberRepository.getMemberById(id);
	}
}