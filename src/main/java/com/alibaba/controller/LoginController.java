package com.alibaba.controller;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dto.User;
import com.alibaba.service.IUserService;


//用户登录Controller
@Controller
@RequestMapping("/login")
public class LoginController {

	@Resource
	private IUserService userService;

	// 登陆操作
	@RequestMapping("/login")
	public String login(HttpServletRequest request,HttpSession session, String userName, String password,
			String verification) throws Exception {
		int reNum=0;
		// 调用service进行用户身份验证
		User user = userService.queryUserByName(userName);
		if(user==null){
			return "redirect:/login/loginUI";
		}
		if (user.getName() != null) {
			if (user.getPassword().equals(password) ) {
				// 在session中保存用户身份信息
				session.setAttribute("userName", userName);
				// 重定向到商品列表页面
				return "redirect:/user/userShows";
			}else{
				reNum=1;
			}
		}else{
			reNum=2;
		}
		request.setAttribute("reNum", reNum);
		// 重定向到登录
		return "login";
	}

	// 登陆界面
	@RequestMapping("/loginUI")
	public String login() {
		// 重定向到登陆界面
		return "login";
	}

	// 用户登陆界面
	@RequestMapping("/userLoginUI")
	public String userLogin() {
		// 重定向到登陆界面
		return "redirect:userLogin";
	}

	/**
	 * 
	 * @param session
	 * @return
	 * @throws Exception
	 */
	// 退出操作
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {

		// 清除session
		session.invalidate();

		// 重定向到商品列表页面
		return "redirect:/items/queryItems.action";
	}

	
}
