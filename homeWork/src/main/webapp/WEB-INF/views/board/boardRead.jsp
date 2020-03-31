<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.title}</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/default.css" />" />
	<script>
		function delete1()
		{
			return confirm("삭제하시겠습니까?");
			
		}

		function update1()
		{
			if(confirm("수정하시겠습니까"))
			{
				location.href = "<c:url value = '/board/boardUpdate?boardnum=${requestScope.read.boardnum}'/>";
			}
		}

		function replyDelete(a,b)
		{
			if(confirm("삭제하시겠습니까?"))
			{
				location.href = "<c:url value ='/board/replyDelete?replynum='/>"+a+"&boardnum="+b;
				
			}
		}

		function backmenu()
		{
			location.href = "<c:url value = '/board/boardList'/>"
		}
	
	</script>
	
	<c:choose>
		<c:when test="${requestScope.replyDelete==true }">
			<script>alert("댓글삭제성공");</script>
		</c:when>
			
		<c:when test="${requestScope.replyDelete==false }">
			<script>alert("댓글삭제실패	");</script>
		</c:when>
	</c:choose>
	
</head>
<body>
<h1>[ 글 읽기 ]</h1>

<table>
	<tr>
		<td class="right" colspan="2">
<!-- 			수정 / 삭제 / 목록 버튼 넣기 -->
<!-- 			수정 / 삭제 / 버튼은 게시글 작성자와 접속 유저가 동일할 경우에만 출력-->
			<c:if test = "${read.userid == sessionScope.userid}">
				
				<input type = "button" value = "수정" onclick = "return update1()">
				
				<a href = "<c:url value = '/board/delete?boardnum=${read.boardnum}'/>">
				<input type = "button" value = "삭제" onclick = "return delete1()">
				</a>
			</c:if>
			
				<input type = "button" value ="뒤로" onclick = "backmenu()">
 				
		</td>
	</tr>
	
	<tr>
		<th>번호</th>
		<td>${read.boardnum}</td>
	</tr>
	
	<tr>
		<th>작성자</th>
		<td>${read.userid}</td>
	</tr>
	
	<tr>
		<th>작성일</th>
		<td>${read.inputdate}</td>
	</tr>
	
	<tr>
		<th>조회</th>
		<td>${read.hit}</td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td>${read.title }</td>
	</tr>
	
	<tr>
		<th>첨부파일</th>
		<td id = "boardfile">
			<a href = "<c:url value = '/board/download?boardnum=${read.boardnum}'/>">
			${read.originalFileName}
			</a>
		</td>
	</tr>
	
	<tr>
		<th>내용</th>
		<td><textarea readonly="readonly">${read.content }</textarea></td>
	</tr>
</table>

<form action="<c:url value = '/board/replyWrite'/>" method = "post">
	<input type = "hidden" name = "boardnum" value = "${read.boardnum}"/>
	<table id = "replyinput">
		<tr>
			<td>
				<input id = "replytext" type = "text" name = "replytext" required="required"/>
				<input id = "replysubmit" type = "submit" value = "댓글 입력"/>
			</td>
		</tr>
	</table>
</form>

<div id = "replydisplay">
	<table class = "reply">
	<c:forEach items="${replyList}" var = "reply">
		<tr>
			<td class = "replytext"> 
				${reply.replytext } 
			</td>
			
			<td class = "replyid"> 
				<span> ${reply.userid} </span>
			</td>
			
			<td class = "replydate">
				<span> ${reply.inputdate} </span>
			</td>
			
			<c:if test = "${sessionScope.userid == reply.userid }">
				<td class = "replybutton">
					<input type = "button" value = "삭제" onclick = "replyDelete('${reply.replynum}','${reply.boardnum}')">
				</td>
			</c:if>
		</tr>
	</c:forEach>
		
	</table>
</div>
	

</body>
</html>
