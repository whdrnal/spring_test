package com.pjg.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private int authLeve;
	private String name;
	private String nickname;
	private String cellphoneNo;
	private String email;
	private boolean delStatus;
	private String delDate;
}