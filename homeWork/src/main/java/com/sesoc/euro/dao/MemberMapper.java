package com.sesoc.euro.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.sesoc.euro.vo.HospitalVO;
import com.sesoc.euro.vo.MemberVO;

public interface MemberMapper {
	
	public int checkid(String userid);
	public int signup(MemberVO vo);
	public int login(MemberVO vo);
	public ArrayList<MemberVO> list();
	public ArrayList<HospitalVO> hoList(HospitalVO vo);
	
}
