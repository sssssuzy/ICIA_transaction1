<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메시지 보내기</title>
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
            background: no-repeat 95% 50%;
            border-radius: 0px;
            }               
select::-ms-expand {display: none;}
</style>
</head>
<body>
	<h1>메시지 보내기</h1>
	<table>
		<tr>
			<td>보내는 사람</td>
			<td><span id="sender">${vo.uid} - ${vo.uname}</span></td>
			<td>포인트</td>
			<td><span id="point">${vo.point}</span></td>
		</tr>
		<tr>
			<td>받는 사람</td>
			<td colspan="3">
				<select id="receiver">
					<c:forEach items="${userList}" var="v">
						<option value="${v.uid}">${v.uname}:${v.uid}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="3"><input type="text" class="keyword" id="message"/></td>
		</tr>
	</table>
	<button id="btnInsert">메세지 보내기</button>
	<button onClick="location.href='/user/'">사용자 목록</button>
	<hr/>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
				<tr class="title">
					<td>NO.</td>
					<td>받는이</td>
					<td>내용</td>
					<td>보낸날짜</td>
					<td>수신상태</td>
				</tr>
			{{#each .}}
				<tr class="row">
					<td>{{mid}}</td>
					<td>{{receiver}}:{{uname}}</td>
					<td>{{message}}</td>
					<td>{{sendDate}}</td>
					<td>{{readCheck readDate}}</td>
				</tr>
			{{/each}}
		</script>
		<script>
			Handlebars.registerHelper("readCheck",function(readDate){
				if(!readDate) return "읽지않음";
			});
		</script>
</body>
<script>
var sender="${vo.uid}";
getList();

//메세지 보내기
$("#btnInsert").on("click",function(){
	var receiver = $("#receiver").val();
	var message = $("#message").val();
	if(!confirm("메세지를 전송하시겠습니까?")) return;
	$.ajax({
		type:"post",
		url:"/message/insert",
		data:{"sender":sender,"receiver":receiver,"message":message},
		success:function(){
			alert("메세지를 전송했습니다.");
			getList();
			var point = parseInt($("#point").html());
			$("#point").html(point+10);
			$("#message").val("");
		}
	});
});

function getList(){
	$.ajax({
		  type:"get",
	      url:"/message/send.json",
	      dataType:"json",
	      data:{"sender":sender},
	      success:function(data){
	         var temp=Handlebars.compile($("#temp").html());
	         $("#tbl").html(temp(data));
	      }
	});
}
</script>
</html>