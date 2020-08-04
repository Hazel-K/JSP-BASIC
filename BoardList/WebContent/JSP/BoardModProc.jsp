<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
	request.setCharacterEncoding("UTF-8"); // post 방식을 위한 char 설정, 할 때마다 쓰기 귀찮으면 server단의 설정을 변경해야 함
	String title = request.getParameter("title");
	String ctnt = request.getParameter("ctnt");
	String strI_student = request.getParameter("i_student");
	String strI_board = request.getParameter("i_board");
	
	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("BoardWrite.jsp?err=10");
		return;
	}
	
	String sql = "UPDATE t_board SET (title, ctnt, i_student) = (SELECT ?, ?, ? FROM dual) WHERE i_board = ?";
		
	Connection con = null;
	PreparedStatement ps = null;
	int rs = -1;
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		ps.setInt(3, Integer.parseInt(strI_student));
		ps.setInt(4, Integer.parseInt(strI_board));
		rs = ps.executeUpdate();
		
	} catch (Exception e) {
		
		e.printStackTrace();
	} finally {
		// if (rs1 != null) { try {rs1.close();} catch (Exception e) {} }
		if (ps != null) { try {ps.close();} catch (Exception e) {} }
		if (con != null) { try {con.close();} catch (Exception e) {} }
	}
	
	int err = 0;
	switch(rs) {
		case 1:
			response.sendRedirect("BoardList.jsp");
			return;
		case 0:
			err = 10;
			break;
		case -1:
			err = 20;
			break;
	}	
	response.sendRedirect("BoardMod.jsp?err=" + err);
	// response.sendRedirect("BoardDetail.jsp?i_board=" + idx);
%>