<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<title>사용자 관리</title>
<style>
table {width: 100%; margin-top:10px;text-align:center; margin-bottom:10px; border-top: 1px solid #444444; border-collapse: collapse;}
tr, td {border-bottom: 1px solid #444444; text-align:center; padding: 10px;}
.btnStyle, button{width: 100px;
              padding: .5em .5em;
              border: 1px solid black;
              background: write;
              color: black;        
              font-weight:bold;
   	}
#pagination{text-align:center;}
a{text-decoration:none; color:#364967;font-size:25px;}
a:hover{font-weight:bold;}
.keyword{width: 200px;
  padding: .5em .5em;
  font-weight: 800;
  border: 1px solid black;
  background: white;
  color:black;        
}
#divHeader{margin-bottom:10px;}
select { width: 130px;
            padding: .5em .5em;
            border: 1px solid black;
            font-family: inherit;
            background: url('/upload/arrow.jpg') no-repeat 95% 50%;
            border-radius: 0px;
            }               
select::-ms-expand {display: none;}
</style>
</head>
<body>
	<h1>사용자 관리</h1>
	<div>
		<table>
			<tr>
				<td>아이디 : </td>
				<td><input type="text" id="txtUid" class="keyword" size=10></td>
			</tr>
			<tr>
				<td>비밀번호 : </td>
				<td><input type="password" class="keyword" id="txtUpw" size=10></td>
			</tr>
			<tr>
				<td>성명:</td>
				<td><input type="text" id="txtUname"  class="keyword" size=10></td>
			</tr>
		</table>
		<input type="button" id="btnInsert" class="btnStyle" value="사용자 등록">
	</div>
	<hr/>
	<div>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
			<tr class="title">
				<td>ID</td>
               <td>PW</td>
               <td>NAME</td>
 			<td>POINT</td>
 			 <td>DEL</td>
 			 <td>SEND</td>
			 <td>RECEIVE</td>
            </tr>
			{{#each .}}
				<tr class="row">
					<td class="uid">{{uid}}</td>
					<td>{{upw}}</td>
					<td>{{uname}}</td>
					<td>{{point}}</td>
					<td><button class="btnDelete">삭제</button></td>
					<td><button class="btnSend">보낸메일함</button></td>
					<td><button class="btnReceive">받은메일함</button></td>
				</tr>
			{{/each}}
		</script>
	</div>
</body>
<script>
getList();

//메세지 보내기
$("#tbl").on("click",".row .btnSend",function(){
	var row = $(this).parent().parent();
	var sender = row.find(".uid").html();
	location.href="/message/sendList?sender="+ sender;
});

//메세지 보관함
$("#tbl").on("click",".row .btnReceive",function(){
	var row = $(this).parent().parent();
	var receiver = row.find(".uid").html();
	location.href="/message/receiveList?receiver="+ receiver;
});

$("#tbl").on("click",".row .btnDelete", function(){
	var row = $(this).parent().parent();
	var uid=row.find(".uid").html();
	if(!confirm(uid+"을(를) 삭제하실래요?")) return;
	$.ajax({
		type:"get",
		url:"/user/delete",
		data:{"uid":uid},
		success:function(){
			alert("사용자 삭제 완료");
			getList();
		}
	});
});

$("#btnInsert").on("click",function(){
	var uid=$("#txtUid").val();
	var upw=$("#txtUpw").val();
	var uname=$("#txtUname").val();
	if(uid==""||upw==""||uname==""){
		alert("내용을 입력해주세요");
		return;
	}
	if(!confirm("사용자를 등록하실래요?")) return;
	$.ajax({
		 type:"get",
	      url:"/user/read",
	      data:{"uid":uid},
	      success:function(data){
	    	  var str=data.uid;
	      	if(str == null){
	      		$.ajax({
	      		type:"post",
	      	      url:"/user/insert",
	      	      data:{"uid":uid,"upw":upw,"uname":uname},
	      	      success:function(data){
	      	    	  alert("사용자 등록완료");
	      	    	   getList();
	      	      }
	      		});
	      	}else{
	      		alert("사용자가 이미 존재합니다.")
	      	}
	      }
	});
});

function getList(){
	$.ajax({
		  type:"get",
	      url:"/user/list.json",
	      dataType:"json",
	      success:function(data){
	         var temp=Handlebars.compile($("#temp").html());
	         $("#tbl").html(temp(data));
	      }
	});
}
</script>
</html>