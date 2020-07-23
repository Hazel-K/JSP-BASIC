<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! // !를 붙이면 전역으로 변경됨(메소드 작성 가능)
	int init(int a) {
	return a;
	}
%>
<% // !를 붙이지 않으면 지역으로 변경됨
	init(4);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판리스트</title>
</head>
<body>
	<div>가나다리스트</div>
</body>
</html>