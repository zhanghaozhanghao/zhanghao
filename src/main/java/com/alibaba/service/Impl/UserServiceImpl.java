package com.alibaba.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.alibaba.dao.IUserDao;
import com.alibaba.dto.User;
import com.alibaba.service.IUserService;

@Service("userService")
public class UserServiceImpl implements IUserService {
	@Resource
	private IUserDao userDao;

	public User getUserById(int userId) {
		return userDao.queryByPrimaryKey(userId);
	}

	public void insertUser(User user) {
		userDao.insertUser(user);
	}

	public void addUser(User user) {
		userDao.insertUser(user);
	}

	public List<User> getAllUser() {
		return userDao.getAllUser();
	}

	@Transactional
	public void modifyUser(User user) {
		userDao.modifyUser(user);
	}

	public void delteUserByBatch(int [] ids) {
		userDao.deleteUserByBatch(ids);
	}

	public void deleteByPrimaryKey(Integer id) {
		userDao.deleteByPrimaryKey(id);
	}

	public User queryUserByName(String name) {
		return userDao.queryUserByName(name);
	}

}
