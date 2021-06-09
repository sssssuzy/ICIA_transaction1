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
<title>메시지 읽기</title>
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
	<h1>메시지 읽기</h1>
	<table border=1 width=730>
		<tr>
			<td width=100 class="title">받은이</td>
			<td>
				<span id="uname">${vo.uname}</span>
				[<span id="sender">${vo.uid}</span>]
			</td>
			<td class="title">포인트</td>
			<td  width=100 id="point">${vo.point}</td>
		</tr>
	</table>
	<button onClick="location.href='/user/'">사용자 목록</button>
	<hr/>
	<table id="tbl" border=1></table>
		<script id="temp" type="text/x-handlebars-template">
				<tr class="title">
					<td>NO.</td>
					<td>보낸이</td>
					<td>내용</td>
					<td>보낸날짜</td>
					<td>읽기</td>
				</tr>
			{{#each .}}
				<tr class="row">
					<td>{{mid}}</td>
					<td>{{sender}}:{{uname}}</td>
					<td>{{message}}</td>
					<td>{{sendDate}}</td>
					<td><button class="btnRead" mid={{mid}} style="{{display readDate}}">읽기</button></td>
				</tr>
			{{/each}}
		</script>
		<script>
			Handlebars.registerHelper("display",function(readDate){
				if(readDate) return "display:none";
			});
		</script>	
</body>
<script>
var receiver="${vo.uid}";
getList();

$("#tbl").on("click",".row .btnRead",function(){
	var mid=$(this).attr("mid");
	$.ajax({
		type:"get",
		url:"/message/read.json",
		data:{"mid":mid},
		dataType:"json",
		success:function(data){
			alert(data.message);
			var point = parseInt($("#point").html());
			$("#point").html(point+5);
			getList();
		}
	});
});

function getList(){
	$.ajax({
		  type:"get",
	      url:"/message/receive.json",
	      dataType:"json",
	      data:{"receiver":receiver},
	      success:function(data){
	         var temp=Handlebars.compile($("#temp").html());
	         $("#tbl").html(temp(data));
	      }
	});
}
</script>
</html>