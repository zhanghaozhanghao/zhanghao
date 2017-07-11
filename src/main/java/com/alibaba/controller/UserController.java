package com.alibaba.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dto.User;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.service.IUserService;

//用户操作Controller
@Controller
@RequestMapping("/user")
public class UserController {
	public Logger logger = Logger.getLogger(UserController.class);
	@Resource
	private IUserService userService;

	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	// 用户列表
	@RequestMapping("/userList")
	public String userList(HttpServletRequest request, Model model) {
		List<User> uList = userService.getAllUser();
		model.addAttribute("uList", uList);
		return "userList";
	}
	@RequestMapping("/userShows")
	public String userList2(HttpServletRequest request, Model model) {
//		List<User> uList = userService.getAllUser();
//		model.addAttribute("uList", uList);
		return "userShows";
	}
	// 用户列表
	@RequestMapping("/userListMap")
	@ResponseBody
	public  Map<String, Object> userListMap(HttpServletRequest request, Model model) {
		List<User> uList = userService.getAllUser();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rows", uList);
		map.put("total", uList.size());
		return map;
	}

	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	// 用户展示
	@RequestMapping("/showUser")
	public String showUser(HttpServletRequest request, Model model) {
		int userId = Integer.parseInt(request.getParameter("id"));
		User user = userService.getUserById(userId);
		model.addAttribute("user", user);
		return "showUser";
	}

	/**
	 * 
	 * @return
	 */
	// 添加用户界面
	@RequestMapping("/addUserUI")
	public String addUserUI() {
		return "addUser";
	}

	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	// 修改用户界面
	@RequestMapping("/modifyUserUI")
	public String modifyUserUI(HttpServletRequest request, Model model) {
		try {
			int userId = Integer.parseInt(request.getParameter("userid"));
			User user = userService.getUserById(userId);
			model.addAttribute("user", user);
		} catch (Exception e) {
			logger.error("", e);
		}
		return "modifyUser";
	}

	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	// 添加用户
	@RequestMapping("/addUser")
	public String addUser(HttpServletRequest request, Model model) {
		try {
			User user = new User();
			user.setName(String.valueOf(request.getParameter("name")));
			user.setPassword(String.valueOf(request.getParameter("password")));
			user.setAge(Integer.parseInt(String.valueOf(request
					.getParameter("age"))));
			userService.addUser(user);
		} catch (Exception e) {
			logger.error("", e);
		}
		return "redirect:/user/userShows";
	}

	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	// 修改用户
	@RequestMapping("/modifyUser")
	public String modifyUser(HttpServletRequest request, Model model) {
		logger.error("error+staret");
		try {
			User user = new User();
			user.setId(Integer.parseInt(String.valueOf(request
					.getParameter("id"))));
			user.setName(String.valueOf(request.getParameter("name")));
			user.setPassword(String.valueOf(request.getParameter("password")));
			user.setAge(Integer.parseInt(String.valueOf(request
					.getParameter("age"))));
			userService.modifyUser(user);
		} catch (Exception e) {
			logger.error("", e);
		}
		return "redirect:/user/userShows";
	}

	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpServletRequest request, Model model) {
		try {
			JSONArray json = JSONArray.parseArray(request
					.getParameter("userids"));
			for (int i = 0; i < json.size(); i++) {
				String id = json.get(i).toString();
				userService.deleteByPrimaryKey(Integer.valueOf(id));
			}
		} catch (Exception e) {
			logger.error("", e);
		}
		return "redirect:/user/userShows";
	}

	// 删除用户
	@RequestMapping("/deleteUsers")
	public String deleteUsers(HttpServletRequest request, Model model,
			int[] userIds) {
		System.out.println(userIds);
		// JSONArray json =
		// JSONArray.parseArray(request.getParameter("userids"));
		// ArrayList users=new ArrayList();
		// for (int i = 0; i < json.size(); i++) {
		// String id = json.get(i).toString();
		// // userService.deleteUserById(Integer.valueOf(id));
		// users.add(Integer.valueOf(id));
		// }
		// Map params=new HashMap<String, ArrayList>();
		// params.put("iList", users);
		userService.delteUserByBatch(userIds);
		return "redirect:/user/userShows";
	}
}
