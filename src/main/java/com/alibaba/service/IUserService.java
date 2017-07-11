package com.alibaba.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.dto.User;

public interface IUserService {  
    
    public User getUserById(int userId);  
  
    public void insertUser(User user);  
  
    public void addUser(User user);  
  
    public List<User> getAllUser();  
    
    public void modifyUser(User user);
   
    public void delteUserByBatch(int [] ids);
    public void deleteByPrimaryKey(Integer id); 
    
    public User queryUserByName(String name);
    
    
}  
