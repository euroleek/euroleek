package com.sesoc.euro.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberVO {
	private int member_seq;
	private String userid;
	private String userpwd;
	private String cat_birth;
}
