<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>用户列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- 
    <link rel="stylesheet" type="text/css" href="styles.css"> 
    -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.6.min.js"></script>
	<script type="text/javascript">
	//修改用户事件
	var modifyUser=function(){
		var arr = new Array();                
        var items = document.getElementsByName("userid");  
        for (i = 0; i < items.length; i++) {                    
            if (items[i].checked) {                        
                arr.push(items[i].value);                    
            }                
        }
        if(arr.length<1){
        	alert("请选择需要修改用户");
        	return ;
        }
        if(arr.length>1){
        	alert("只能选择修改一位用户");
        	return ;
        }
       // alert("选择的个数为：" + arr[0]);
        location.href = 'user/modifyUserUI?userid='
			+ arr[0];
	}
	//删除用户事件
	var deleteUser=function(){
		var arr = new Array();                
        var items = document.getElementsByName("userid");  
        for (i = 0; i < items.length; i++) {                    
            if (items[i].checked) {                        
                arr.push(items[i].value);                    
            }                
        }
        if(arr.length<1){
        	alert("请选择需要删除用户");
        	return ;
        }
       
       // alert("选择的个数为：" + arr[0]);
        location.href = 'user/deleteUser?userids='
			+JSON.stringify(arr);;
	}
	//删除用户事件
	var deleteUsers=function(){
		var arr = new Array();                
        var items = document.getElementsByName("userid");  
        for (i = 0; i < items.length; i++) {                    
            if (items[i].checked) {                        
                arr.push(items[i].value);                    
            }                
        }
        if(arr.length<1){
        	alert("请选择需要删除用户");
        	return ;
        }
       
       // alert("选择的个数为：" + arr[0]);
        location.href = 'user/deleteUsers?userIds='
			+arr;
	}
	//添加用户事件
	var addUser=function(){
		location.href = 'user/addUserUI';
	}
	</script>
</head>

<body>
	<table class="table table-striped">
		<tr>
			<th></th>
			<th>用户名称</th>
			<th>用户年龄</th>
		</tr>
		<c:forEach items="${uList }" var="u">
			<tr>
				<td><input  type="checkbox" name="userid" value="${u.id}" /></td>
				<td>${u.name}</td>
				<td>${u.age }</td>
			</tr>
		</c:forEach>
	</table>
	<button onclick="modifyUser()">修改</button>
	<button onclick="addUser()">添加</button>
	<button onclick="deleteUsers()">删除</button>
</body>
</html>
