package com.sesoc.euro.schedule;



import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sesoc.euro.dao.MemberDAO;
import com.sesoc.euro.vo.MemberVO;




@Component
public class Schedule {
	
	@Autowired
	private MemberDAO dao;
	
	@Scheduled(cron = "0 25 15 * * *")
	public void test1()
	{
		String today = null;
		Date date1 = new Date();
		Date day1 = null;
		Calendar cal = Calendar.getInstance();
		cal.setTime(date1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//55일전 첫번째 백신 맞기 하루전
		cal.add(Calendar.DATE, -55);
		today = sdf.format(cal.getTime());
		
		
		ArrayList<MemberVO> list = dao.schedule();
		for (int i = 0; i < list.size() ; i++) 
		{
			//가져와서 8주 11주 14주 종합 17 복막 20 광견병
			
			String a = list.get(i).getCat_birth().substring(0, 10);
			DateFormat dateFormat = new SimpleDateFormat ("yyyy-MM-dd");
			
			try 
			{
				Date date = dateFormat.parse(a);
				day1 = dateFormat.parse(today);
				int compare = day1.compareTo(date);
				if(compare == 0)
				{
					//여기서 첫번째 문자 보내는거랑 연결시켜주는거, 여기서 맞은 날짜에서 3주를 더해주어야 하지만 일단 고정값으로 만 해보자
					//추후에는 고양이 관리 페이지를 별도로 만들어서 고양이 이름과 생일을 가져와서 활용할예정이다(이 구조만 이해하라는뜻)
					System.out.println(list.get(i).getUserid() + "님 첫번째 백신 맞추기 하루 전 입니다");
					
				}
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
		}
		
		cal.setTime(date1);// 초기화
		
	}
	

}
