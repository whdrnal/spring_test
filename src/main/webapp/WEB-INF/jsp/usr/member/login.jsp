<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="../common/head.jspf"%>
<head>
<style>
table {
	width: 95rem;
	height: 10rem;
}

table, th, td {
	border: 2px solid #e2e8f0;
}
</style>
</head>

<section class="mt-5">
	<div class="container mx-auto px-3">
		<form method="POST" action="../member/doLogin">
			<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>로그인아이디</th>
						<td>
							<input name="loginId" class="w-96 input input-bordered ml-4" type="text" placeholder="로그인아이디" />
						</td>
					</tr>
					<tr>
						<th>로그인비밀번호</th>
						<td>
							<input name="loginPw" class="w-96 input input-bordered ml-4" type="password" placeholder="로그인비밀번호" />
						</td>
					</tr>
				</tbody>
			</table>
			<div>
				<button type="submit" class="btn btn-primary">로그인</button>
				<button type="button" class="btn btn-outline btn-secondary mt-2" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>