<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.pjg.exam.demo.util.Ut"%>

<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../common/head.jspf"%>
<head>
<style>
table {
	width: 95rem;
	height: 400px;
}

table, th, td {
	border: 2px solid #e2e8f0;
}
</style>
</head>

<section class="mt-5">
	<div class="container mx-auto px-3">
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
					<th>이름</th>
					<td class="px-4">${rq.loginedMember.name}</td>
				</tr>
				<tr>
					<th>별명</th>
					<td class="px-4">${rq.loginedMember.nickname}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td class="px-4">${rq.loginedMember.email}</td>
				</tr>
				<tr>
					<th>별명</th>
					<td class="px-4">${rq.loginedMember.cellphoneNo}</td>
				</tr>
			</tbody>
		</table>
		<div class="mt-2">
			<a href="../member/checkPassword?replaceUri=${Ut.getUriEncoded('../member/modify')}" class="btn btn-primary">회원정보수정</a>
			<button type="button" class="btn btn-outline btn-secondary" onclick="history.back();">뒤로가기</button>
		</div>
	</div>

</section>

<%@ include file="../common/foot.jspf"%>