<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../common/head.jspf"%>
<head>
<style>
table {
	width: 95rem;
	height: 150px;
}

table, th, td {
	border: 2px solid #e2e8f0;
}
</style>
</head>

<section class="mt-5">
	<div class="container mx-auto px-3">
		<form method="POST" action="../member/doCheckPassword">
			<input type="hidden" name="replaceUri" value="${param.replaceUri}" />
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>로그인아이디</th>
						<td class="px-4">${rq.loginedMember.loginId}</td>
					</tr>
					<tr>
						<th>로그인비밀번호</th>
						<td>
							<input name="loginPw" class="w-96 input input-bordered ml-2" type="password" placeholder="비밀번호" required="required" />
						</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-2">
				<button type="submit" class="btn btn-primary">비밀번호 확인</button>
				<button type="button" class="btn btn-outline btn-secondary" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>