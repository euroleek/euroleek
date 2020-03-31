<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>집사의 조건</title>
	<%-- <link href = "<c:url value = '/resources/css/bootstrap.css'/>" rel = "stylesheet">  --%>
	<link href = "<c:url value = '/resources/css/default.css'/>" rel = "stylesheet">
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<style type="text/css">
	body
	{
		background-image:url("resources/img/main.jpg");
		background-color: #d9e5ff;
		background-size: 100% 100%;
	}
	#title
	{
		font-family:serif;
	}
	
		
	</style>
	
			
	<c:if test="${requestScope.loginResult == false }">
			<script> 
				alert("암호또는 id 일치하지 않습니다");
				location.reload();
			</script>
			
	</c:if>
</head>

<body>
	
	
		<div id = "title">집사의 조건</div>
		<form action="<c:url value = '/member/login'/>" method = "post" >
				<table id = "mainTable">
					<tr>
						
						<td> 
							<input type="text" name = "userid" style="width:200px;height:50px; border-radius: 10px;" placeholder="아이디를 입력하시오">
							<input type="password" name = "userpwd" style="width:200px;height:50px; border-radius: 10px;" placeholder="비밀번호를 입력하시오">
						</td>
					</tr>
					<tr height = 30px;>
						
						<td> 
							<input type = "submit" value = " 로그인 " style="width:100px;height:30px; border-radius: 10px;">
						</td>
					</tr>
					
					<tr height = 30px;>
						
						<td> 
							<a href = "<c:url value = '/member/signupForm'/>">
								<input type = "button" value = "회원 가입" id = "login" style="width:100px;height:30px; border-radius: 10px;">
							</a>
						</td>
					</tr>
					
						
					
					<tr align = "center" height = 30px;>
						<td>	
							<a href = "<c:url value = '/myTest'/>">
								<input type = "button" value = "  지도  " style="width:100px;height:30px; border-radius: 10px;">
							</a>
						</td>
						
					</tr>
					
					<tr align = "center" height = 30px;>
						<td>	
							<a href = "<c:url value = '/searchMap'/>">
								<input type = "button" value = "길찾기 url 연결" style="width:100px;height:30px; border-radius: 10px;">
							</a>
						</td>
						
					</tr>
					
					<tr align = "center" height = 30px;>
						<td>	
							<a href="javascript:void chatChannel()">
							  <img src="https://developers.kakao.com/assets/img/about/logos/channel/consult_small_yellow_pc.png"/>
							</a>
							
						</td>
						
						
						
					</tr>
					
					<tr align = "center" height = 30px;>
						<td>	
							<a href = "<c:url value = '/myLocation'/>">
								<input type = "button" value = "내 주변의 동물병원" style="width:100px;height:30px; border-radius: 10px;">
							</a>
						</td>
						
					</tr>
					
					
				</table>
			</form>
		
		
	<!-- <script src = "/resources/js/jquery-3.4.1.js"></script>
	<script type="text/javascript" src = "/resources/js/bootstrap.js"></script>  -->
	
	<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('bcb304f051b2968e7a9473de010e09a0');
    function chatChannel() {
      Kakao.Channel.chat({
        channelPublicId: '_hHcGxb' // 카카오톡 채널 홈 URL에 명시된 id로 설정합니다.
      });
    }
  //]]>
</script>

</body>
</html>
