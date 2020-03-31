<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>

<link href = "<c:url value = '/resources/css/default.css'/>" rel = "stylesheet">

<script src = "<c:url value = '/resources/js/jquery-3.4.1.js'/>"></script>


<script type="text/javascript">
function idCheckForm()
	{
		var w = screen.availWidth;
		var h = screen.availHeight;
		open("<c:url value = '/member/idCheckForm'/>", "_blank", 'width=' +w/4+ ',height=' +h/4+ ',top=' +h*3/8+ ',left='+w*3/8);
		//open은 새텝을 열어주는거 _blank는 새창으로 여는거
		document.getElementById("check").setAttribute("disabled", "disabled");
		
	}

	$(function(){
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		if((day+"").length<2 )
		{
			day = "0"+day;	
		}
		if((month+"").length<2)
		{
			month = "0"+month;
		}
		var finaldate = String(year) + String(month) + String(day);
		

		$('#signupBtn').on("click", function(){
			var inputDate = $('#year').val().replace(/-/gi,"");
			if($('#userpwd').val() != $('#userpwd1').val())
			{
				alert("비밀번호를 다시 확인해주세요");
			}
			else if($('#userpwd').val() == "")
			{
				alert("비밀번호를 입력하시오");
			}
			else if($('#year').val() =="")
			{
				alert("날짜를 제대로 입력하시오");
			}
			else if($('#year').val().substr(0,1)!="2")
			{
				alert("년도 오류!");
			}
			else if(eval(finaldate)<eval(inputDate))
			{
				alert("미래 입력 불가");
			}
				
			
			
			else
			{
				var userid = $('#userid').val();
				var userpwd = $('#userpwd').val();
				var cat_birth = $('#year').val();
				$.ajax({
					url : "signup",
					type : "post",
					data : {
						userid : userid
						,userpwd : userpwd
						,cat_birth : cat_birth
					},
					success : function(data){
						alert("회원가입에 성공하셨습니다");
						window.location.href = "../member/login?userid="+userid+"&userpwd="+userpwd;
					},
					error : function(){
						
					}
				});
			}


		});
		
	});

</script>
</head>

<body>
	<table id = "signupTable">
				<tr>
					<th colspan = "2" id = "signupTableth">
						회원 가입
					</th>	
				</tr>
				
				<tr>
					<td class = "signuptd1">ID</td>
					<td> 
						<input type="text" name = "userid" id = "userid" required = "required" readonly="readonly">
						<input type = "button" value = "중복검사" id = "check" onclick ="idCheckForm()">
						
					</td>
				</tr>
				
				<tr>
					<td class = "signuptd1">PW</td>
					<td class = "signuptd2"><input type="password" name = "userpwd" id = "userpwd" required = "required"></td>
				</tr>
				
				<tr>
					<td class = "signuptd1">PW 확인</td>
					<td class = "signuptd2">
						<input type="password" name = "userpwd1" id = "userpwd1" required = "required"> 
					</td>
				</tr>
				
				<tr>
					<td class = "signuptd1">고양이 생일</td>
					<td class = "signuptd2">
						<input type="date" required = "required" id = "year">
						
					</td>
				</tr>
				
				
				
				<tr align = "center">
					<td colspan="2" class = "signuptd2">
						<input type = "button" value = "가입" disabled="disabled" id = "signupBtn" >
					
					</td>
				</tr>
			</table>
</body>
</html>