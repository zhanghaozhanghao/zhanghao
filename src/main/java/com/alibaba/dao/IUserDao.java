package com.alibaba.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.dto.User;

public interface IUserDao {

	public User queryByPrimaryKey(Integer id);

	public List<User> queryUserByBatch(Map<String, Object> params);

	public void insertUser(User user);

	public void insertUserByBatch(List<User> list);

	public void deleteByPrimaryKey(Integer id);

	public void deleteUserByBatch(int[] ids);

	public void modifyUser(User user);

	public List<User> getAllUser();

	public User queryUserByName(String name);
}
