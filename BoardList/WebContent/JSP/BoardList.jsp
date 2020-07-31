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
<% // !를 붙이지 않으면 지역으로 변경됨
	List<BoardVO> boardList = new ArrayList();
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = "SELECT i_board, title FROM t_board ORDER BY i_board DESC"; // CRUD 구문에 ; 을 허용하면 안됨, 인젝션 공격당함, 웬만하면 * 쓰면 안됨

	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery(); // SELECT때만 씀, 나머지 CRUD 구문에는 executeUpdeate를 사용
		
		while(rs.next()){ // 1부터 순차적으로 레코드가 있는지를 확인, true/false 리턴
			int i_board = rs.getInt("i_board");
			String title = rs.getNString("title"); // NString UTF 유니코드 때문에 나온 것. String과 차이는 없지만 100% 문제가 없음
			
			BoardVO vo = new BoardVO(); // VO객체는 반드시 While문 안에 선언할 것
			vo.setI_board(i_board);
			vo.setTitle(title);
			
			boardList.add(vo);
		} // 이런 작업을 parsing 작업이라고 함
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) { try {rs.close();} catch(Exception e) {} }
		if (ps != null) { try {ps.close();} catch(Exception e) {} }
		if (con != null) { try {con.close();} catch(Exception e) {} }
	} // 열었으면 닫아야 함. 연 순서의 반대로 닫아주어야 하므로 close();는 역순이 된다. close();는 따로 나눠놓는 것이 FM, 닫지 않으면 서버가 죽는다.
	// 지역변수는 선언하는 곳에 따라 스코프(살아있는 범위)가 달라짐
	// 메소드가 속하는 경로 (BoardList_jsp.java) 메소드, 전역 변수를 만들고 싶다면 무조건 ! 붙일 것
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판리스트</title>
<style>
body {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

table {
	border-collapse: collapse;
}

th, td {
	padding: 1em;
	border: 1px solid black;
	text-align: center;
}
</style>
</head>
<body>
	<div>
		<h1>가나다리스트</h1>
	</div>
	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>

		<% for(BoardVO vo : boardList) {%>
		<tr>
			<td><%=vo.getI_board()%></td>
			<td><a href="/JSP/BoardDetail.jsp?i_board=<%=vo.getI_board()%>"><%=vo.getTitle()%></a></td>
			<!-- href의 ? 뒷부분은 hashmap 스타일, key와 value를 통해 해당 데이터를 찾아낸다. query가 노출되냐 안되느냐에 따라 get, post방식으로 나뉜다. -->
		</tr>
		<%}%>
	</table>
	<button onclick="location.href='BoardWrite.jsp'">글쓰기</button>
</body>
</html>