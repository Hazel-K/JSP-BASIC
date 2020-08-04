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
request.setCharacterEncoding("UTF-8"); // post 방식을 위한 char 설정, 할 때마다 쓰기 귀찮으면 server단의 설정을 변경해야 함
String strI_board = request.getParameter("i_board");
int i_board = 0;

try {
	i_board = Integer.parseInt(strI_board);
} catch (Exception e) {}

String sql = "SELECT i_board, title, ctnt, i_student FROM t_board WHERE i_board=?";

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

String title = "";
String ctnt = "";
String i_student = "";

try {
	con = getCon();
	ps = con.prepareStatement(sql);
	ps.setInt(1, i_board);
	rs = ps.executeQuery();
	
	if(rs.next()) {
		title = rs.getNString("title");
		ctnt = rs.getNString("ctnt");
		i_student = rs.getNString("i_student");
	} else {
		%>alert('잘못된 접근입니다.');<%
		response.sendRedirect("BoardList.jsp");
		return;
	}
} catch(Exception e) {
	e.printStackTrace();
} finally {
	if (rs != null) { try {rs.close(); } catch ( Exception e ) {} }
	if (ps != null) { try {ps.close(); } catch ( Exception e ) {} }
	if (con != null) { try {con.close(); } catch ( Exception e ) {} }
}
%>
<%
String msg = "";
String err = request.getParameter("err");
if (err != null) {
	switch (err) {
		case "10" :
	msg = "등록할 수 없습니다.";
	break;
		case "20" :
	msg = "DB 에러 발생";
	break;
	}
}
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
			<input type="hidden" name="i_board" value="<%=i_board %>">
			<div>
				<label for="title"> 제목 : </label><input id="title" type="text"
					name="title" value="<%=title %>">
			</div>
			<div>
				<label for="ctnt"> 내용 : </label>
				<textarea id="ctnt" name="ctnt"><%=ctnt %></textarea>
			</div>
			<div>
				<label for="i_student"> 작성자 : </label><input id="i_student"
					type="text" name="i_student" value="<%=i_student %>">
			</div>
			<div>
				<input type="submit" value="글수정">
			</div>
		</form>
		<a href="BoardList.jsp"><button>리스트로</button></a>
	</div>
	<script>
		function eleValid(ele, nm) {
			if (ele.value.length == 0) {
				alert(nm + '을(를) 입력해주세요.');
				ele.focus();
				return true;
			}
		}
		function chk() {
			if (eleValid(frm.title, '제목')) {
				return false;
			} else if (eleValid(frm.ctnt, '내용')) {
				return false;
			} else if (eleValid(frm.i_student, '작성자')) {
				return false;
			}
		}
	</script>
</body>
</html>