<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		margin : 10px 0px;
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
	<div>글 작성</div>
	<div>
		<form action="BoardWriteProc.jsp" method="post" class = "form1">
			<!-- name은 QueryString에 값을 날려주는 key값으로 사용된다. id와 class로는 사용할 수 없음 -->
			<div><label for="title"> 제목 : </label><input id="title" type="text" name="title"></div>
			<div><label for="ctnt"> 내용 : </label><textarea id="ctnt" name="ctnt"></textarea></div>
			<div><label for="i_student"> 작성자 : </label><input id="i_student" type="text" name="i_student"></div>
			<div><input type="submit" value="글등록"></div>
		</form>
	</div>
</body>
</html>