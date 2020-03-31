<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복확인</title>
<script src = "<c:url value = '/resources/js/jquery-3.4.1.js'/>"></script>
<script>
	function submitId()
	{
		//부모클래스인 signupForm의 문서객체를 가져와야된다, 아이디랑 섭밋 버튼에 값을 건드릴려면
		var useridDoc = opener.document.getElementById("userid");
		var signupBtnDoc = opener.document.getElementById("signupBtn");
		var check = opener.document.getElementById("check");
		check.removeAttribute("disabled");	
		useridDoc.value = "${userid}";
		signupBtnDoc.removeAttribute("disabled");
		close();
	}
	</script>
	
	<script type="text/javascript">
	$(function(){
		/* x버튼 누르면 */
		$(window).on('beforeunload', function(){
			$('#check', opener.document).removeAttr('disabled');
		});

		/* 닫기 버튼 */
		$('#closeFunc').on("click", function(){
			$('#check', opener.document).removeAttr('disabled');
			close();
		});
		/* 중복검사   */
		$('#idcheck').on("click", function(){
			var userid = $('#userid').val();
			$.ajax({
				url : "checkid",
				type : "post",
				data : {
					userid : userid
				},
				success : function(data){
					
					if(data[0]=="tt")
					{
						$('#btn').removeAttr('disabled');
						$('p').html("사용 가능합니다");
					}
					else
						$('p').html("사용 불가");
				},
				error : function(){
				
				}
			});
		});

		

		
	});

	function submitId()
	{
		//부모클래스인 signupForm의 문서객체를 가져와야된다, 아이디랑 섭밋 버튼에 값을 건드릴려면
		var useridDoc = opener.document.getElementById("userid");
		var signupBtnDoc = opener.document.getElementById("signupBtn");
		var check = opener.document.getElementById("check");
		check.removeAttribute("disabled");	
		var userid = $('#userid').val();
		useridDoc.value = userid;
		signupBtnDoc.removeAttribute("disabled");
		close();
	}
	
	
	</script>
</head>

<body>
	<h1>ID 중복체크</h1>
	 
		<input type="text" name="userid" value="${userid }" required="required" id = "userid">
		<input type="button" value="중복확인" id = "idcheck">
						
		<input type="button" id="btn" value="사용" onclick="submitId()" disabled="disabled">
		<input type="button" value="닫기" id="closeFunc">
	
	
		<p></p>
			
		
		
</body>
</html>
