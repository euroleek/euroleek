package com.sesoc.euro.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardVO {
	
	private int boardnum;	
	private String userid;		
	private String title; 			
	private String content;	
	private String inputdate; 	
	private int hit ;	
	private String originalFileName;
	private String savedFileName;
}
