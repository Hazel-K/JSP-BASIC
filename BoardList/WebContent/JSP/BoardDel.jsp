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
	Connection con = null;
	PreparedStatement ps = null;
	int rs = -1;
	int i_board = 0;
	String strI_board = request.getParameter("i_board");
	String sql = "DELETE FROM t_board WHERE i_board = ?";
	if (strI_board == null) { // 실무에서는 try catch로 감싸거나 strI_board가 완벽한 숫자형 스트링인지를 체크해야 함
%>
		<script>
			alert('잘못된 접근입니다.');
			location.href='BoardList.jsp';
		</script>
<%
			return;
		}
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		i_board = Integer.parseInt(strI_board);
		ps.setInt(1, i_board);
		rs = ps.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		// if (rs != null) { try {rs.close();} catch (Exception e) {} }
		if (ps != null) { try {ps.close();} catch (Exception e) {} }
		if (con != null) { try {con.close();} catch (Exception e) {} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
	<script>
		(function (temp) {
			if (temp == -1) {
				alert('삭제에 실패했습니다. 다시 확인해주세요.');
				location.href = 'BoardDetail.jsp?i_board=' + <%=i_board%>;
				return;
			} else if (temp == 0) {
				alert('이미 삭제되었거나 존재하지 않는 페이지입니다.');
			} else {
				alert('데이터가 정상적으로 삭제되었습니다.');
			}
			location.href='BoardList.jsp'; // JSP 단에선 response.sendRedirect("BoardList.jsp"); 로 이동 가능
		}(<%=rs%>));
	</script>
</body>
</html>