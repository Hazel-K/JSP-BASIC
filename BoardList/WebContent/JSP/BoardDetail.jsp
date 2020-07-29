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
	String sql = "SELECT title, ctnt, i_student FROM t_board WHERE i_board = " + strI_board;

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	BoardVO vo = new BoardVO();
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		rs.next();
		String title = rs.getNString("title");
		String ctnt = rs.getNString("ctnt");
		int i_student = rs.getInt("i_student");
			
		vo.setTitle(title);
		vo.setCtnt(ctnt);
		vo.setI_student(i_student);
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) { try {rs.close();} catch(Exception e) {} }
		if (ps != null) { try {ps.close();} catch(Exception e) {} }
		if (con != null) { try {con.close();} catch(Exception e) {} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div>상세 페이지 : <%=strI_board %></div>
	<div>제목 : <%=vo.getTitle() %></div>
	<div>작성자 : <%=vo.getI_student() %></div>
	<div>내용 : <%=vo.getCtnt() %></div>
</body>
</html>