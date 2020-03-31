package com.sesoc.euro.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;

import com.sesoc.euro.vo.BoardVO;



public interface BoardMapper 
{
	public ArrayList<BoardVO> boardList(HashMap<String, String> map, RowBounds rb);
	public int write(BoardVO vo);
	public BoardVO read(int boardnum);
	public void update(BoardVO vo);
	public int delete(BoardVO vo);
	public int updateboard(BoardVO vo);
	public void deleteFile(BoardVO vo);
	public int getTotal(HashMap<String, String> map);
}
