package com.sesoc.euro.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sesoc.euro.vo.HospitalVO;
import com.sesoc.euro.vo.MemberVO;




@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	
	public int checkid(String userid)
	{
		int checkid = 0;
		try 
		{	
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			checkid = mapper.checkid(userid);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return checkid;
	}
	
	public boolean signup(MemberVO vo)
	{
		int result = 0;
		try 
		{
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			result = mapper.signup(vo);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if(result ==0 ) return false;
		return true;
	}
	
	public boolean login(MemberVO vo, HttpSession session)
	{
		int returnid = 0;
		try 
		{	
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			returnid = mapper.login(vo);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if(returnid == 0 ) return false;
		session.setAttribute("userid", vo.getUserid());
		return true;
	}
	
	public void logout(HttpSession session)
	{
		session.removeAttribute("userid");
	}
	
	public ArrayList<MemberVO> schedule()
	{
		ArrayList<MemberVO> list = null;
		try
		{
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			list = mapper.list();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<HospitalVO> hoList(HospitalVO vo)
	{
		ArrayList<HospitalVO> list = null;
				
		try
		{
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			list = mapper.hoList(vo);
					
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	
	
	
	

}
