package com.sesoc.euro.dao;

import java.util.ArrayList;

import com.sesoc.euro.vo.ReplyVO;



public interface ReplyMapper {
	public void replyWrite(ReplyVO vo);
	public ArrayList<ReplyVO> replyList(int boardnum);
	public int replyDelete(ReplyVO vo);

}
