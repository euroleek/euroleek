<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	
	
	<link href = "<c:url value = '/resources/css/bootstrap.css'/>" rel = "stylesheet"> 
	
	<meta charset="UTF-8">
	<title>게시판</title>
	
	<script src = "<c:url value = '/resources/js/jquery-3.4.1.js'/>"></script>
	<script type="text/javascript">
		$(function(){
			
			$('#ment').fadeOut(5000);
			$('#ment').fadeIn(5000); 
			
		});

		function pageProc(currentPage, searchItem, searchKeyword) 
		{
			location.href="<c:url value='/board/boardList' />" 
				+"?currentPage=" + currentPage 
				+ "&searchItem=" + searchItem
				+ "&searchKeyword=" + searchKeyword;
		}
	</script>
	
	<style type="text/css">
		#boardtitle
		{
			color : green;
			text-align: center;
		}
		#logbut
		{
			position:fixed;
			right: 5%;
			color : blue;
		}
		#navigator {
			border: none;
			text-align: center;
		}
	</style>


</head>
<body>	
		
		<h2 id = "ment">${sessionScope.userid} 님 환영합니다</h2> 
		
    	<h1 id = "boardtitle">[ 게시판 ]</h1>     
    	<a  href = "<c:url value = '/member/logout'/>">
			<input type = "button" value = "logout" id = "logbut" >
		</a><br/>
		
		<form action = "<c:url value = '/board/boardList'/>" method = "get">
			<select name = "searchItem">
				<option value = "userid" selected="selected">작성자</option>
				<option value = "title">제목</option> 
				<option value = "content">내용</option>
			</select>
			<input type = "text" name = "searchKeyword">
			<input type = "submit" value = "검색" onclick = "return search()"><br>
		
		</form>
		
		
	
	
	<table class="table table-striped">
	  <thead class="thead-light">
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">날짜</th>
	      <th scope="col">조회수</th>
	    </tr>
	  </thead>
	  
	  <tbody>
	  
	  	<c:forEach items="${requestScope.list }" var="board"> 
		
		 
		    <tr>
		      <th scope="row">${board.boardnum }</th>
		      <td>${board.userid }</td>
		      <td id = "title">
					<a href = "<c:url value = '/board/read?boardnum=${board.boardnum}'/>">
					${board.title }
					</a>
				</td>
		      <td>${board.hit }</td>
		      <td id = "inputdate">${board.inputdate}</td> 
		    </tr>
	    </c:forEach>
	    
	  </tbody>
	  
	  <tr>
			<td id="navigator" colspan="5">
				<a href="javascript:pageProc(${navi.currentPage - navi.pagePerGroup}, '${searchItem}', '${searchKeyword}')">◁◁ </a> &nbsp;&nbsp;
				<a href="javascript:pageProc(${navi.currentPage - 1}, '${searchItem}', '${searchKeyword}')">◀</a> &nbsp;&nbsp;
					
				<c:forEach var="counter" begin="${navi.startPageGroup}" end="${navi.endPageGroup}"> 
					<c:if test="${counter == navi.currentPage}"></b></c:if>
						<a href="javascript:pageProc(${counter}, '${searchItem}', '${searchKeyword}')">${counter}</a>&nbsp;
					<c:if test="${counter == navi.currentPage}"></b></c:if>
				</c:forEach>
				&nbsp;&nbsp;
				<a href="javascript:pageProc(${navi.currentPage + 1}, '${searchItem}', '${searchKeyword}')">▶</a> &nbsp;&nbsp;
				<a href="javascript:pageProc(${navi.currentPage + navi.pagePerGroup}, '${searchItem}', '${searchKeyword}')">▷▷</a>
				<a href= "<c:url value= '/board/boardWriteForm'/>" >
					<input type = "button" value = "글쓰기">
				</a> 
			</td>
		</tr>
	  
	</table>
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	<script type="text/javascript" src = "<c:url value = '/resources/js/bootstrap.js'/>"></script> 	
	
	
</body>
</html>