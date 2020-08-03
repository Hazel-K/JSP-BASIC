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
	if (strI_board == null) { // 실무에서는 try catch로 감싸거나 strI_board가 완벽한 숫자형 스트링인지를 체크해야 함
%>
		<script>
			alert('잘못된 접근입니다.');
			location.href='BoardList.jsp';
		</script>
<%
		return;
	}
	// String sql = "SELECT a.title, a.ctnt, a.i_student, b.nm FROM t_board a INNER JOIN t_student b ON a.i_student = b.i_student WHERE i_board = " + strI_board;
	String sql = "SELECT a.title, a.ctnt, a.i_student, b.nm FROM t_board a INNER JOIN t_student b ON a.i_student = b.i_student WHERE i_board = ?";
	// ps.setString(1, strI_board); 1번째 ?에 request.getParameter를 넣겠다는 의미, 다만 이 경우 두 번째 값이 String이므로 실제로 들어가는 값은 'n'의 형태이다.
	int i_board = Integer.parseInt(strI_board);
	String nm = "";

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	BoardVO vo = new BoardVO();
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board); // 옆과 같이 값을 parsing 해주는 것이 좋다.
		rs = ps.executeQuery();
		
		if (rs.next()) { // 데이터가 0줄일 수도 있으므로 if문을 통해 확인
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			nm = rs.getNString("nm");
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) { try {rs.close();} catch(Exception e) {} }
		if (ps != null) { try {ps.close();} catch(Exception e) {} }
		if (con != null) { try {con.close();} catch(Exception e) {} }
	}
	
	if (vo.getTitle() == null) {
		%>
		<script>
			alert(`존재하지 않는 페이지입니다.`);
			location.href='BoardList.jsp';
		</script>
		<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div><a href="BoardList.jsp">리스트로 가기</a></div>
	<div><a href="#" onclick="procDel(<%=i_board%>);">삭제</a></div>
	<div><a href="BoardMod.jsp?i_board=<%=i_board%>">수정</a></div>
	<div>번호 : <%=strI_board %></div>
	<div>제목 : <%=vo.getTitle() %></div>
	<div>작성자 : <%=nm %></div>
	<div>내용 : <%=vo.getCtnt() %></div>
	<script>
		function procDel(i_board) {
			// alert('i_board : ' + i_board);
			if(confirm('삭제하시겠습니까?')) {
				location.href = 'BoardDel.jsp?i_board=' + i_board;
			}
		}
	</script>
</body>
</html>