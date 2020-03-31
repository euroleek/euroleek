package com.sesoc.euro.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.sesoc.euro.dao.MemberDAO;
import com.sesoc.euro.vo.HospitalVO;
import com.sesoc.euro.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
	@RequestMapping(value = "member/signupForm", method = RequestMethod.GET)
	public String signupForm() {
				
		return "member/signupForm";
	}
	
	@RequestMapping(value = "/member/idCheckForm", method = RequestMethod.GET)
	public String idCheckForm() {
		
		return "member/idCheckForm";
	}
	@RequestMapping(value = "/myTest", method = RequestMethod.GET)
	public String myTest() {
	
		return "/myTest";
	}
	
	@RequestMapping(value = "/searchMap", method = RequestMethod.GET)
	public String searchMap() {
	
		return "/searchMap";
	}
	
	@RequestMapping(value = "/myLocation", method = RequestMethod.GET)
	public String myLocation(Model model, HospitalVO vo)
	{
		return "/myLocation";
	}
	
	@ResponseBody
	@RequestMapping(value = "/myL", method = RequestMethod.GET)
	public ArrayList<String> myL(HospitalVO vo, Model model) {
		ArrayList<String> list = new ArrayList<>();
		ArrayList<HospitalVO> list1 = dao.hoList(vo);
		list.add(list1.get(0).getId());
		list.add(list1.get(0).getPhone());
		list.add(list1.get(0).getLocation());
		
		list.add(list1.get(1).getId());
		list.add(list1.get(1).getPhone());
		list.add(list1.get(1).getLocation());
		
		list.add(list1.get(2).getId());
		list.add(list1.get(2).getPhone());
		list.add(list1.get(2).getLocation());
		
		list.add(list1.get(0).getXValue());
		list.add(list1.get(0).getYValue());
		list.add(list1.get(1).getXValue());
		list.add(list1.get(1).getYValue());
		list.add(list1.get(2).getXValue());
		list.add(list1.get(2).getYValue());
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/checkid", method = {RequestMethod.GET, RequestMethod.POST})
	public ArrayList<String> checkid(String userid, RedirectAttributes rttr) {
		String result = "ff";
		
		if(dao.checkid(userid)==0) result = "tt";
		ArrayList<String> list = new ArrayList<>();
		list.add(result);
		list.add(userid);
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/check", method = {RequestMethod.GET, RequestMethod.POST})
	public ArrayList<String> check(String start, String end, RedirectAttributes rttr) {
		ArrayList<String> list = new ArrayList<>();
		list.add(start);
		list.add(end);
		return list;
	}
	
	@RequestMapping(value = "member/signup", method = {RequestMethod.GET, RequestMethod.POST})
	public String signup(MemberVO vo, RedirectAttributes rttr) {
	
		//DB에 vo 값을 저장하는 로직을 수행하는 메서드를 호출
		boolean result = dao.signup(vo); //new로 객체 생성 안해도 잘 돌아간다 >> MemberDAO 클래스에서 @Repository를 붙여 사용가능하게 만듬
		// ioc(di) 위에서 @Autowired를 사용해서 호출. 이렇게 등록된 걸 bean이라 한다
		rttr.addFlashAttribute("signupResult", result); 
		
		return "redirect:/member/login?userid="+vo.getUserid()+"&userpwd="+vo.getUserpwd(); 
	}
	
	@RequestMapping(value = "member/login", method = {RequestMethod.GET, RequestMethod.POST})
	public String login(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
	
		boolean check = dao.login(vo, session);
		if(check)
		{
			return "redirect:/board/boardList";
		}
		rttr.addFlashAttribute("loginResult", check);
		return "redirect:/";
	}
	
	@RequestMapping(value = "member/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		dao.logout(session);
		return "redirect:/";
	}
}
