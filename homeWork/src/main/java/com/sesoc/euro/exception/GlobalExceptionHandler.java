package com.sesoc.euro.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(NullPointerException.class)
	public String nullpointerHandler(Model model)
	{
		model.addAttribute("msg", "NullPointerException 발생");
		return "/exception/error";
	}
	
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Model model)
	{
		model.addAttribute("msg", "Exception 발생");
		return "/exception/error";
	}
}
