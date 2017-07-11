package com.alibaba.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.util.RandomValidateCode;

@Controller
@RequestMapping("/codeVerify")
public class CodeCotroller {
	
	@RequestMapping("/check")
	public void verify(HttpServletRequest request, HttpServletResponse response){
		RandomValidateCode r = new RandomValidateCode();
        r.makeValidateImage(request, response);
	}
	
	@RequestMapping("/result")
	public void result(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String validateCode = (String) (request.getSession().getAttribute("validateCode"));
        response.getWriter().write(validateCode);
	}

}
