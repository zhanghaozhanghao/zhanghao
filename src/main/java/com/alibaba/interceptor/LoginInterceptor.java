package com.alibaba.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

//登录认证的拦截器 
public class LoginInterceptor implements HandlerInterceptor {
	// 用于身份认证、身份授权
	// 比如身份认证，如果认证通过表示当前用户没有登陆，需要此方法拦截不再向下执行
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		// 获取请求的url
	//	String url = request.getRequestURI();

		// 判断session
		HttpSession session = request.getSession();
		// 从session中取出用户份信息
		String userName = (String) session.getAttribute("userName");
		if (userName != null) {
			// 身份存在，放行
			return true;
		}

		// 执行这里表示用户身份需要验证，跳转到登录界面
		/*request.getRequestDispatcher("").forward(request,
				response);*/
		response.sendRedirect("/MySSM/login/loginUI");
		return false;
	}
	// 进入Handler方法之后，返回modelAndView之前执行
	// 应用场景从modelAndView出发：将公用的模型数据(比如菜单导航)在这里
	// 传到视图，也可以在这里统一指定视图
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		System.out.println("LoginInterceptor......postHandle");

	}

	// 执行Handler完成执行此方法
	// 应用场景：统一异常处理，统一日志处理
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		System.out.println("LoginInterceptor......afterHandle");

	}

}
