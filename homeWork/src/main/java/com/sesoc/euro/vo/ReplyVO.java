package com.sesoc.euro.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class ReplyVO {
	private int replynum;
	private int boardnum;
	private String userid;
	private String replytext;
	private String inputdate;
}
