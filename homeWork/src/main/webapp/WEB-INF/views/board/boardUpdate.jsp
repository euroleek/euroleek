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
				if(confirm("수정하시겠습니까?"))
				{
					var updateFormDoc = document.getElementById("updateForm");
					updateFormDoc.submit();
				}
			}
		</script>
<link href = "<c:url value = '/resources/css/default.css'/>" rel = "stylesheet">
</head>
<body>
<script>
</script>

<h1>[ 글 수정 ]</h1>

<form action="<c:url value = '/board/update'/>" method="post" id = "updateForm" enctype="multipart/form-data">

	<table>
		<tr>
			<th>작성자</th>
			<td><input type = "text" value = "${sessionScope.userid}" disabled="disabled"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type = "text" name = "title" id = "title1" value = "${read.title}" required = "required"></td>
			<!-- required 를 쓰면 값이 무조건 들어가야 넘어간다 -->
		</tr>
		<tr>
			<th>첨부 파일</th>
			<td>
				${read.originalFileName}
				<a href = "<c:url value = '/board/deleteFile?boardnum=${read.boardnum}'/>" >
					<input type = "button" value = "삭제" >
				</a>
				<input type = "file" name = "uploadFile">
				
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea cols="5" rows="10" placeholder = "내용" name = "content" id = "content">${read.content}</textarea> </td>
		</tr>
		<tr>
			<td class="right" colspan="2">
				<input type = "button" value = "확인" onclick ="writeConfirm()">
				<input type = "reset" value = "리셋">
				<a href = "<c:url value = '/board/write'/>">
					<input type = "button" value ="뒤로">
 				</a>
				
				
		
			</td>
		</tr>
	</table>
	<input type = "hidden" name = "boardnum" value ="${read.boardnum}">
</form>
</body>
</html>
