<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户列表</title>
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.com/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.com/easyui/themes/color.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.com/easyui/demo/demo.css">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript"
	src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
	/* $(document).ready(function() {
		$("input").focus(function() {
			$("span").css("display", "inline").fadeOut(2000);
		});
	}); */
	/* $(document).ready(function() {
		$("#userType").click(function() {
			alert("段落被点击了。");
		});
	}); */
	$(function() {
		$('#w').window('close');
		$('#updateWin').window('close');
		$("#e").window('close');

		$('#mydatagrid').datagrid({
			title : '用户列表',
			iconCls : 'icon-ok',
			//width : 1300,
			fit : true,
			pageSize : 10,//默认选择的分页是每页5行数据
			pageList : [ 5, 10, 15, 20 ],//可以选择的分页集合
			pageNumber : 1,
			//beforePageText: '第',//页数文本框前显示的汉字 
			//afterPageText: '页    共 {pages} 页', 
			//displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',  
			nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取
			striped : true,//设置为true将交替显示行背景。
			collapsible : true,//显示可折叠按钮
			//toolbar:"#tabs",//在添加 增添、删除、修改操作的按钮要用到这个
			toolbar : "#navigationBar",
			url : 'userListMap',
			columns : [ [ {
				field : 'name',
				title : '用户姓名',
				width : 100,
				align : 'center'
			}, {
				field : 'password',
				title : '密码',
				width : 100,
				align : 'center'
			}, {
				field : 'age',
				title : '年龄',
				width : 100,
				align : 'center'
			},
			/* {field:'id',title:'操作',width:130,formatter:function(value,record){
			 return '<font color="red">' + value + '</font>';
			}} */
			] ],
			loadMsg : '数据装载中......',
			singleSelect : false,//为true时只能选择单行
			fitColumns : false,//允许表格自动缩放，以适应父容器
			//sortName : 'studentid',//当数据表格初始化时以哪一列来排序
			//sortOrder : 'desc',//定义排序顺序，可以是'asc'或者'desc'（正序或者倒序）。
			rowStyler : function(index, record) {
				if (record.age > '22') {
					return 'background : #D2D2D5;';
				}
			},
			remoteSort : false,
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			} ] ],
			pagination : true,//表示在datagrid设置分页
			rownumbers : true
		//行数
		});

		var p = $('#mydatagrid').datagrid('getPager');
		$(p).pagination({
			pageSize : 10,//每页显示的记录条数，默认为10   
			pageList : [ 5, 10, 15, 20 ],//可以设置每页记录条数的列表   
			beforePageText : '第',//页数文本框前显示的汉字   
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
		});

		//在datagrid实例化之后调用这个方法。
		$("#mydatagrid").datagrid({}).datagrid("keyCtr");

		var fields = $('#mydatagrid').datagrid('getColumnFields');
		for (var i = 0; i < fields.length; i++) {
			var opts = $('#mydatagrid').datagrid('getColumnOption', fields[i]);
			var muit = "<div name='"+  fields[i] +"'>" + opts.title + "</div>";
			$('#mm').html($('#mm').html() + muit);
		}
		$('.searchbox ').appendTo('.datagrid-toolbar');
		$('#sss').appendTo('.datagrid-toolbar');
		$('#sss').searchbox({
			menu : '#mm'
		});
	});

	function del() {
		//选中要删除的行
		var rows = $("#mydatagrid").datagrid('getSelections');
		if (rows.length == 0) {
			$.messager.alert("提示", "请选中一行进行删除！");
			return;
		} else {
			if (rows.length > 0) {//选中几行的话触发事件
				$.messager.confirm("提示", "您确定要删除这些数据吗？", function(res) {
					if (res) {
						//alert('confirmed:'+res);
						var codes = [];
						for (var i = 0; i < rows.length; i++) {
							codes.push(rows[i].id);
							//alert(rows[i].id);
						}
						//alert(codes);

						location.href = 'deleteUser?userids='
								+ JSON.stringify(codes);
					}
				});
			}
		}
	}

	function edit() {
		var rows = $('#mydatagrid').datagrid('getSelections');
		var row = $('#mydatagrid').datagrid('getSelected');
		if (rows.length > 1) {
			$.messager.alert("提示", "仅能选择一行！");
			return;
		} else if (rows.length == 0) {
			$.messager.alert("提示", "请选中一行进行修改！");
			return;
		} else {
			debugger;
			$('#uf_id').textbox('setValue', row.id);
			$('#uf_userName').textbox('setValue', row.name);
			$('#uf_password').textbox('setValue', row.password);
			$('#uf_age').textbox('setValue', row.age);

			//隐藏修改窗口中的id栏位
			$("#editUserFormDivID").css("display", "none");
			//打开修改窗口
			$('#updateWin').window('open');
		}

	}

	function add() {
		$('#w').window('open');
	}

	function refresh() {
		$('#mydatagrid').datagrid('reload');//刷新
	}

	function doSearch() {
		var fname = $('#name').val();
		var params = {};
		params["fname"] = fname;
		$.ajax({
			url : "searchUser1",
			// 数据发送方式
			type : "post",
			// 接受数据格式
			dataType : "json",
			// 要传递的数据
			data : params,
			// 回调函数，接受服务器端返回给客户端的值，即result值
			success : function(res) {
				if (res == null || res == "") {
					$.messager.alert("提示", "Sorry,没有找到符合条件的数据！", "info");
				} else {
					$('#mydatagrid').datagrid('loadData', res);
				}

			},
			error : function() {
				$.messager.alert("提示", "Sorry,没有找到符合条件的数据！", "info");
				//alert("Sorry,没有找到符合条件的数据！");  
			}
		});
	}
</script>
</head>
<body>
	<table id="mydatagrid"></table>
	<div id="navigationBar">
		<a href="#" class="easyui-linkbutton" onclick="add()"
			data-options="iconCls:'icon-add',plain:true">添加</a> <a href="#"
			class="easyui-linkbutton" onclick="del()"
			data-options="iconCls:'icon-remove',plain:true">删除</a> <a href="#"
			class="easyui-linkbutton" onclick="edit()"
			data-options="iconCls:'icon-edit',plain:true">修改</a> <a href="#"
			class="easyui-linkbutton" onclick="refresh()"
			data-options="iconCls:'icon-reload',plain:true">刷新</a> <span>用户姓名:</span>
		<!-- Product ID: -->
		<input id="name" style="line-height: 26px; border: 1px solid #ccc" />
		<a href="#" class="easyui-linkbutton" onclick="doSearch()"
			data-options="iconCls:'icon-search',plain:true">查找</a>
	</div>
	<div id="w" class="easyui-window" title="Basic Window"
		data-options="iconCls:'icon-save'"
		style="width: 500px; height: 280px; padding: 10px;">
		<form id="addUserForm" action="addUser" method="post">
			<div>
				<label for="name">姓名：</label> <input id="name"
					class="easyui-textbox" required="required" name="name" type="text">
			</div>
			<div>
				<label for="name">密码：</label> <input id="password"
					class="easyui-textbox" required="required" name="password"
					type="password">
			</div>
			<div>
				<label for="age">年龄：</label> <input id="age" class="easyui-textbox"
					required="required" name="age" type="text">
			</div>

			<div>
				<button id="btn" type="submit">提交</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset" value="重置">
			</div>
		</form>
	</div>

	<div id="updateWin" class="easyui-window" title="Basic Window"
		data-options="iconCls:'icon-save'"
		style="width: 500px; height: 280px; padding: 10px;">
		<form id="editUserForm" action="modifyUser" method="post">
			<div id="editUserFormDivID">
				<label for="id">编号：</label> <input id="uf_id" class="easyui-textbox"
					name="id" type="text">
			</div>
			<div>
				<label for="name">姓名：</label> <input id="uf_userName"
					class="easyui-textbox" name="name" type="text">
			</div>
			<div>
				<label for="password">密码：</label> <input id="uf_password"
					class="easyui-textbox" name="password" type="text">
			</div>
			<div>
				<label for="age">年龄：</label> <input id="uf_age"
					class="easyui-textbox" name="age" type="text">
			</div>
			<div>
				<button id="updatebtn" type="submit">修改</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset" value="重置">
			</div>
		</form>
	</div>
</body>
</html>