<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

		<script>
			function writeConfirm()
			{
				var title = document.getElementById("title1");
				var content = document.getElementById("content");
				if(title.value.length==0)
				{
					alert("제목값을 입력해주세요");
					return false;
				}
				if(content.value.length==0)
				{
					alert("내용을 입력해주세요");
					return false;
				}
				return confirm("등록하시겠습니까"); //확인 누르면 true 아니오 누르면 false
			}
		</script>
<link href = "<c:url value = '/resources/css/default.css'/>" rel = "stylesheet">
</head>
<body>
<script>
</script>

<h1>[ 글쓰기 ]</h1>

<form action="<c:url value = '/board/write'/>" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<th>작성자</th>
			<td><input type = "text" value = "${sessionScope.userid}" disabled="disabled"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type = "text" name = "title" id = "title1" placeholder = "제목" required = "required"></td>
			<!-- required 를 쓰면 값이 무조건 들어가야 넘어간다 -->
		</tr>
		<tr>
			<th>첨부 파일</th>
			<td>
				<input type = "file" name = "uploadFile" value = "파일 선택">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea cols="5" rows="10" placeholder = "내용" name = "content" id = "content"></textarea> </td>
		</tr>
		<tr>
			<td class="right" colspan="2">
				<input type = "submit" value = "확인" onclick ="return writeConfirm()">
				<input type = "reset" value = "리셋">
				<input type = "button" value = "뒤로" onclick = "history.back(-1);">
		
				
		
			</td>
		</tr>
	</table>
</form>
</body>
</html>
