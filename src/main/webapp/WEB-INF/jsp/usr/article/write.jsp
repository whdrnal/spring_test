<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 작성" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../../common/toastUiEditorLib.jspf"%>
<head>
<style>
table {
	width: 95rem;
	height: 44rem;
}


table, th, td {
	border: 2px solid #e2e8f0;
    height: 4rem;
}
</style>
</head>



<script>
  let submitWriteFormDone = false;
  function submitWriteForm(form) {
    if (submitWriteFormDone) {
      alert('처리중입니다.');
      return;
    }
    form.title.value = form.title.value.trim();
    if (form.title.value.length == 0) {
      alert('제목을 입력해주세요.');
      form.title.focus();
      return;
    }
    const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
    const markdown = editor.getMarkdown().trim();
    if (markdown.length == 0) {
      alert('내용을 입력해주세요.');
      editor.focus();
      return;
    }
    form.body.value = markdown;
    form.submit();
    submitWriteFormDone = true;
  }
</script>

<section class="mt-5">
	<div class="container mx-auto px-3">
		<form onsubmit="submitWriteForm(this); return false;" method="POST" action="../article/doWrite">
			<input type="hidden" name="body">
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>작성자</th>
						<td class="px-4">${rq.loginedMember.nickname}</td>
					</tr>
					<tr>
						<th>게시판</th>
						<td>
							<select class="select select-bordered ml-2" name="boardId">
								<option selected disabled>게시판을 선택해주세요.</option>
								<option value="1">공지사항</option>
								<option value="2">자유게시판</option>
								<option value="3">QnA</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input required="required" class="w-96 input input-bordered ml-2" name="title" type="text" placeholder="제목" />
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-editor">
								<script type="text/x-template"></script>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-2">
				<button type="submit" class="btn btn-primary">작성</button>
				<button type="button" class="btn btn-secondary btn-outline" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
		<div class="btns"></div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>