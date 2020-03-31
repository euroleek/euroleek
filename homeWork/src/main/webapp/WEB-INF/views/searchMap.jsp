<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>길찾기</title>
<script src = "<c:url value = '/resources/js/jquery-3.4.1.js'/>"></script>
<style type="text/css">
	html
	{
		height :85%;
	}
	body
	{
		min-height : 100%;
		background-image:url("resources/img/searchmap.jpg");
		background-size: 100% 100%;
		background-repeat: no-repeat;
		background-color: #d9e5ff;
	}
	
	table {
	width:300px;
	height: 100px;
	
	text-align: center;
	font-weight: bold;
	top : 40%;
	margin-top: 70px;
	margin-left: auto;
	margin-right: auto;
	
	border-radius: 10px;;
	opacity: 0.9;
}

input
{
	vertical-align: 15px;
	border-radius: 10px;;
	height: 30px;
}

td {
	background-color : white;
	
	border-style: solid;
	border-width: 1px;
	padding: 3px;
	font-size : 40px;
	border-radius: 10px;;
	
	
}
th{
	height:40px;
	font-size: 20px;
	border-radius: 10px;;
}
</style>

<script type="text/javascript">
$(function(){
	$('#check').on("click", function(){
		var start = $('#start').val();
		var end = $('#end').val();
		var w = window.open("about:blank","_blank","width=1000, height=700, top=0,left=0,scrollbars=no");
		$.ajax({
			url : "check",
			type : "post",
			data : {
				start : start
				,end : end
			},
			success : function(data){
				
				w.location.href = "http://map.daum.net/?sName="+ data[0] +"&eName=" + data[1]
				
			},
			error : function(){
			
			}
		});
	});

	

	
});



</script>
</head>

<body>
	<table>
		<tr>
			<td width="200px">
				<input type="text" placeholder="출발지를 입력히시오" id = "start" required="required" >
			</td>
			<td rowspan="2">
				<input type = "button" value = "길찾기" style="height: 90px;text-align: left;" id = "check">
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="text" placeholder="도착지를 입력히시오" id = "end" value = "${end }" required="required">
			</td>
			
		</tr>
	</table>

</body>
</html>