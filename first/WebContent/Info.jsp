<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="blog.hyojin4588.connection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
String url = "jdbc:oracle:thin:@localhost:1521:orcl";
String userName = "hr";
String password = "koreait2020";

Class.forName("oracle.jdbc.driver.OracleDriver");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
String sql = "SELECT * FROM countries";

List<CountriesVO> list = new ArrayList<CountriesVO>();

try {
	con = DriverManager.getConnection(url, userName, password);
	ps = con.prepareStatement(sql);
	rs = ps.executeQuery();

	while (rs.next()) {
		String country_id = rs.getString("country_id");
		String country_name = rs.getString("country_name");
		int region_id = rs.getInt("region_id");
		CountriesVO vo = new CountriesVO();

		vo.setCountry_id(country_id);
		vo.setCountry_name(country_name);
		vo.setRegion_id(region_id);
		
		list.add(vo);
	}
} catch (Exception e) {}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인포메이션</title>
</head>
<body>
	<div>나라 정보</div>
	<table>
		<tr>
			<th>Country_ID</th>
			<th>Country_Name</th>
			<th>Region_ID</th>
		</tr>
		<% for(CountriesVO vo : list) { %>
		<tr>
			<td><%=vo.getCountry_id() %></td>
            <td><%=vo.getCountry_name() %></td>
            <td><%=vo.getRegion_id() %></td>
        </tr>
		<% } %>
	</table>
</body>
</html>