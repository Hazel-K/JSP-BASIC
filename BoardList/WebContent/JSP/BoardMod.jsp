<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="blog.hyojin4588.web.BoardVO"%>
<%! // !를 붙이면 전역으로 변경됨(메소드 작성 가능)
	private Connection getCon() throws Exception{
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "hr";
		String pass = "koreait2020";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection(url, user, pass);
		System.out.println("접속 성공!");
		return conn;
	}
	//메소드가 속하는 경로 (BoardList_jsp.java) 에 생성된 클래스 내부에 적혀 있음
%>
<%
	String strI_board = request.getParameter("i_board"); // hashmap의 key 가져오기
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>글 수정</div>
	<div>
		<form action="BoardModProc.jsp" method="post" class="form1"
			onsubmit="return chk()">
			<!-- name은 QueryString에 값을 날려주는 key값으로 사용된다. id와 class로는 사용할 수 없음 -->
			<div>
				<label for="title"> 제목 : </label><input id="title" type="text"
					name="title">
			</div>
			<div>
				<label for="ctnt"> 내용 : </label>
				<textarea id="ctnt" name="ctnt"></textarea>
			</div>
			<div>
				<label for="i_student"> 작성자 : </label><input id="i_student"
					type="text" name="i_student">
			</div>
			<div>
				<input type="submit" value="글등록">
			</div>
		</form>
	</div>
</body>
</html>