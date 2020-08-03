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
	int i_student = 0;
	
	if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
		response.sendRedirect("BoardWrite.jsp?err=10");
		return;
	}
	
	String sql = "INSERT INTO t_board(i_board, title, ctnt, i_student) "
		+"SELECT nvl(MAX(i_board), 0) + 1, ?, ?, ?"
		+"FROM t_board";
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs1 = null;
	int rs = -1;
	int idx = 0;
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		
		ps.setNString(1, title);
		ps.setNString(2, ctnt);
		i_student = Integer.parseInt(strI_student);
		ps.setInt(3, i_student);
		rs = ps.executeUpdate();
		
		sql = "SELECT MAX(i_board) FROM t_board";
		ps = con.prepareStatement(sql);
		rs1 = ps.executeQuery();
		if (rs1.next()) {
			idx = rs1.getInt(1);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs1 != null) { try {rs1.close();} catch (Exception e) {} }
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
	response.sendRedirect("BoardWrite.jsp?err=" + err);
	// response.sendRedirect("BoardDetail.jsp?i_board=" + idx);
%>