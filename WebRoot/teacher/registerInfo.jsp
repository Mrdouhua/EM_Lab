<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var teacherId = '${sessionScope.user.userId }';
	$(function(){
		$("#teacher_registerInfo_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/teacher/Register_getRegister?teacherId='+teacherId,
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			idField:'id',
			sortName:'userName',
			sortOrder:'desc',
			pageList:[10],
			showHeader:true,
			singleSelect:true,
			columns : [[{
				field : 'id',
				width : 60,
				hidden:true
			},{
				field : 'userId',
				title : '学号',
				width : 150,
				align:'left'
			},{
				field : 'userName',
				title : '学生姓名',
				width : 100,
				align:'left'
			},{
				field : 'grade',
				title : '年级',
				width : 60,
				align:'left'
			},{
				field : 'academy',
				title : '学院',
				width : 60,
				align:'left'
			},{
				field : 'discipline',
				title : '专业',
				width : 60,
				align:'left'
			},{
				field : 'cls',
				title : '班级',
				width : 60,
				align:'left'
			},{
				field : 'sex',
				title : '性别',
				width : 30,
				align:'left'
			},{
				field : 'phone',
				width : 60,
				title : '电话',
				align:'left'
			},{
				field : 'state',
				width : 60,
				hidden:true
			},{
				field : 'grant',
				title : '授权状态',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					if(row.state=='yes'){
						return '<span style="color:red;">已被授权</span>&nbsp;&nbsp;&nbsp;<span style="cursor:pointer;color:red;" onclick="teacher_registerInfo_deleteRegister(\''+row.userId+'\');">删除</span>';
					}else{
						return '<span style="cursor:pointer;color:#8080C0;" onclick="teacher_registerInfo_grantRegister(\''+row.userId+'\');">未被授权</span>&nbsp;&nbsp;&nbsp;<span style="cursor:pointer;color:red;" onclick="teacher_registerInfo_deleteRegister(\''+row.userId+'\');">删除</span>';
					}
				}
			}]]
		});
	});
	
	//教师授权操作
	function teacher_registerInfo_grantRegister(userId){
		$.messager.confirm('请确认','你确定要让该用户登录该系统吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/teacher/Register_grantRegister',
					type:'post',
					data:{
						userId:userId
					},
					dataType:'json',
					success:function(d){
						if(d){
							$.messager.show({
								title:'提示',
								msg:'恭喜你，授权成功！'
							});
						}else{
							$.messager.show({
								title:'提示',
								msg:'该授权失败，请与管理员联系！'
							});
						}
					}
				});
			}else{
				$.messager.show({
					title:'提示',
					msg:'该授权被取消了！'
				});
			}
		});
	}
	/*
		删除注册用户
	*/
	function teacher_registerInfo_deleteRegister(userId){
		$.messager.confirm('请确认','你确定要删除该注册用户吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/teacher/Register_deleteRegister',
					type:'post',
					data:{
						userId:userId
					},
					dataType:'json',
					success:function(d){
						if(d){
							$.messager.show({
								title:'提示',
								msg:'删除成功！'
							});
							$("#teacher_registerInfo_datagrid").datagrid('load');
						}else{
							$.messager.show({
								title:'提示',
								msg:'对不起，删除失败！'
							});
						}
						$("#teacher_registerInfo_datagrid").datagrid('rejectChanges');
					}
				});
			}else{
				$.messager.show({
					title:'提示',
					msg:'取消了删除操作！'
				});
			}
		});
	}
</script>

<table id="teacher_registerInfo_datagrid"></table>
