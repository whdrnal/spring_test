package com.pjg.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Member {
	
	private int id;
	private String regDate;
	private String upDate;
	private String loginId;
	private String loginPw;
	private String name;
	private String nickname;
	private String cellphoneNo;
	private String email;
	private boolean delStatus;
	private boolean delDate;
}
