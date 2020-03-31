package com.sesoc.euro.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.multi.MultiFileChooserUI;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.style.DefaultValueStyler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sesoc.euro.dao.BoardDAO;
import com.sesoc.euro.dao.PageNavigator;
import com.sesoc.euro.vo.BoardVO;
import com.sesoc.euro.vo.ReplyVO;



@Controller
public class BoardController {

	@Autowired
	private BoardDAO dao;
	
	//게시글 출력
	@RequestMapping(value = "board/boardList", method = RequestMethod.GET)
	public String boardList(Model model,
		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
		@RequestParam(name = "searchItem", defaultValue = "userid") String searchItem,
		@RequestParam(name = "searchKeyword", defaultValue = "") String searchKeyword
		)
	{
		PageNavigator navi = dao.getNavi(currentPage, searchItem, searchKeyword);
		ArrayList<BoardVO> list = dao.boardList(navi, searchItem, searchKeyword);
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchKeyword", searchKeyword);
		return "/board/boardList";
	}
	//쓰는 폼으로 이동
	@RequestMapping(value = "board/boardWriteForm", method = RequestMethod.GET)
	public String goboard() {
	
		return "board/boardWriteForm";
	}
	//게시글 등록
	@RequestMapping(value = "board/write", method = {RequestMethod.GET, RequestMethod.POST})
	public String write(BoardVO vo, HttpSession session, RedirectAttributes rttr, MultipartFile uploadFile) {
		boolean result = false;
		if(dao.write(vo, session, uploadFile)==1) result = true;
		rttr.addFlashAttribute("writeResult", result);
		return "redirect:/board/boardList"; 
	}
//	//조회수 업데이트
//	@RequestMapping(value = "/board/update", method = {RequestMethod.GET, RequestMethod.POST})
//	public String update(BoardVO vo, RedirectAttributes rttr) {
//		dao.update(vo);
//		rttr.addAttribute("boardnum", vo.getBoardnum());
//		return "redirect:/board/read"; 
//	}
//	
//	
//	//게시글 불러오기
//	@RequestMapping(value = "/board/read", method = {RequestMethod.GET, RequestMethod.POST})
//	public String read(@RequestParam("boardnum") int boardnum, BoardVO vo, HttpSession session, RedirectAttributes rttr, Model model) {
//		vo.setBoardnum(boardnum);
//		BoardVO result = dao.read(vo, session);
//		model.addAttribute("read", result);
//		return "board/boardRead"; 
//	}
	
	//게시글 불러오기
	@RequestMapping(value = "/board/read", method = RequestMethod.GET)
	public String read(BoardVO vo, int boardnum, RedirectAttributes rttr, Model model) {
		dao.update(vo);
		BoardVO result = dao.read(boardnum);
		ArrayList<ReplyVO> replyList = dao.replyList(boardnum);
		model.addAttribute("read", result);
		model.addAttribute("replyList", replyList);
		return "/board/boardRead"; 
	}

	//삭제
	@RequestMapping(value = "/board/delete", method = RequestMethod.GET)
	public String read(RedirectAttributes rttr, BoardVO vo, HttpSession session) {
		boolean result = false;
		if(dao.delete(vo, session)==1) result = true;
		rttr.addFlashAttribute("delResult", result);
		return "redirect:/board/boardList"; 
	}
	
	//첨부파일삭제버튼
	@RequestMapping(value = "/board/deleteFile", method = RequestMethod.GET)
	public String deleteFile(RedirectAttributes rttr, BoardVO vo, HttpSession session) {
		dao.deleteFile(vo, session);
		rttr.addAttribute("boardnum", vo.getBoardnum());
		return "redirect:/board/boardUpdate";
	}
	
	// update 이동
	@RequestMapping(value = "board/boardUpdate", method = {RequestMethod.GET, RequestMethod.POST})
	public String boardUpdateMove(int boardnum, HttpSession session, RedirectAttributes rttr, Model model) {
		BoardVO result = dao.read(boardnum);
		model.addAttribute("read", result);
		return "board/boardUpdate";
	}

	
	//update
	@RequestMapping(value = "/board/update", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateboard(RedirectAttributes rttr, BoardVO vo, HttpSession session, MultipartFile uploadFile) {
		boolean result = false;
		if(dao.updateboard(vo, session, uploadFile)!=0) result = true;
		rttr.addFlashAttribute("upResult", result);
		//1안 return "redirect:/board/upread?boardnum="+vo.getBoardnum();
		rttr.addAttribute("boardnum", vo.getBoardnum());
		return "redirect:/board/upread";
	}
	
	//조회수 증가 막기
	@RequestMapping(value = "/board/upread", method = RequestMethod.GET)
	public String upread(int boardnum, HttpSession session, RedirectAttributes rttr, Model model) {
		BoardVO result = dao.read(boardnum);
		model.addAttribute("read", result);
		return "/board/boardRead"; 
	}
			
	//댓글 입력
	@RequestMapping(value = "board/replyWrite", method = RequestMethod.POST) 
	public String replyWrite(ReplyVO vo, HttpSession session) 
	{
		dao.replyWrite(vo, session);
		return "redirect:/board/read?boardnum=" +vo.getBoardnum();
	}
	
	//댓글 삭제
	
	@RequestMapping(value = "board/replyDelete", method = RequestMethod.GET) 
	public String replyDelete(ReplyVO vo, HttpSession session, RedirectAttributes rttr) 
	{
		boolean result = false;
		if(dao.replyDelete(vo, session)==1) result = true;
		rttr.addFlashAttribute("replyDelete", result);
		return "redirect:/board/read?boardnum=" +vo.getBoardnum();
	}
	
	@RequestMapping(value = "board/download", method = RequestMethod.GET) 
	public void download(int boardnum, HttpServletResponse response)
	{
		dao.download(boardnum, response);
	}
	


	
	
	
	
	
	
}
