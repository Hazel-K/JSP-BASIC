<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>글쓰기</title>
<style type="text/css">
body {
	display: flex;
	flex-direction: column;
	align-items: center;
}

body div {
	margin: 10px 0px;
}

body>div:nth-child(1) {
	font-size: 25px;
	font-weight: 800;
}

body>div:nth-child(2) {
	width: 700px;
}

.form1 {
	display: flex;
	flex-direction: column;
}

.form1 div {
	display: flex;
}

.form1 label {
	margin-right: 10px;
}
</style>
</head>
<body>
	<div id="msg">
		<%=msg%></div>
	<div>글 작성</div>
	<div>
		<form action="BoardWriteProc.jsp" method="post" class="form1"
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