<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../../common/toastUiEditorLib.jspf"%>
<head>
<style>
table {
  width: 95rem;
  height: 30rem;
}

textarea {
 height:30rem;
 margin-top: 10px;
}

table, th, td {
  border: 2px solid #e2e8f0;
}
</style>
</head>


<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__viewDone';
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		localStorage.setItem(localStorageKey, true);
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
	$(function() {
		// 실전코드
		// ArticleDetail__increaseHitCount();
		// 임시코드
		setTimeout(ArticleDetail__increaseHitCount, 500);
	})
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
    <div>
      <table>
        <colgroup>
          <col width="200" />
        </colgroup>
        <tbody>
          <tr>
            <th>번호</th>
            <td class="px-4">
              <div class="badge badge-primary">${article.id}</div>
            </td>
          </tr>
          <tr>
            <th>작성날짜</th>
            <td class="px-4">${article.forPrintType2RegDate}</td>
          </tr>
          <tr>
            <th>수정날짜</th>
            <td class="px-4">${article.forPrintType2UpdateDate}</td>
          </tr>
          <tr>
            <th>작성자</th>
            <td class="px-4">${article.extra__writerName}</td>
          </tr>
          <tr>
            <th>조회</th>
            <td class="px-4">
              <span class="badge badge-primary article-detail__hit-count">${article.hitCount}</span>
            </td>
          </tr>
          <tr class="px-4">
            <th>추천</th>
            <td class="px-4">
              <div class="flex items-center">
                <span class="badge badge-primary">${article.goodReactionPoint}</span>
                <span>&nbsp;</span>
                <c:if test="${actorCanMakeReaction}">
                  <a
                    href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                    class="btn btn-xs btn-primary btn-outline"> 좋아요 👍 </a>
                  <span>&nbsp;</span>
                  <a
                    href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                    class="btn btn-xs btn-secondary btn-outline"> 싫어요 👎 </a>
                </c:if>

                <c:if test="${actorCanCancelGoodReaction}">
                  <a
                    href="/usr/reactionPoint/doCancelGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                    class="btn btn-xs btn-primary"> 좋아요 👍 </a>
                  <span>&nbsp;</span>
                  <a onclick="alert(this.title); return false;" title="먼저 좋아요를 취소해주세요." href="#"
                    class="btn btn-xs btn-secondary btn-outline"> 싫어요 👎 </a>
                </c:if>

                <c:if test="${actorCanCancelBadReaction}">
                  <a onclick="alert(this.title); return false;" title="먼저 싫어요를 취소해주세요." href="#"
                    class="btn btn-xs btn-primary btn-outline"> 좋아요 👍 </a>
                  <span>&nbsp;</span>
                  <a
                    href="/usr/reactionPoint/doCancelBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                    class="btn btn-xs btn-secondary"> 싫어요 👎 </a>
                </c:if>
              </div>
            </td>
          </tr>
          <tr>
            <th>제목</th>
            <td class="px-4">${article.title}</td>
          </tr>
          <tr>
            <th>내용</th>
            <td class="px-4">
              <div class="toast-ui-viewer">
                <script type="text/x-template">
					${article.body}
				</script>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="btns">
      <c:if test="${empty param.listUri}">
        <button class="btn btn-secondary mt-2" type="button" onclick="history.back();">뒤로가기</button>
      </c:if>
      <c:if test="${not empty param.listUri}">
        <a class="btn btn-active btn-secondary mt-4" href="${param.listUri}">뒤로가기</a>
      </c:if>

      <c:if test="${article.extra__actorCanModify}">
        <a class="btn btn-primary" href="../article/modify?id=${article.id}">게시물 수정</a>
      </c:if>
      <c:if test="${article.extra__actorCanDelete}">
        <a class="btn btn-primary" onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;"
          href="../article/doDelete?id=${article.id}">게시물 삭제</a>
      </c:if>
    </div>
  </div>
</section>

<script>
	// 댓글작성 관련
	let ReplyWrite__submitFormDone = false;
	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
			return;
		}
		// 좌우공백 제거
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('댓글을 입력해주세요.');
			form.body.focus();
			return;
		}
		if (form.body.value.length < 2) {
			alert('댓글내용을 2자이상 입력해주세요.');
			form.body.focus();
			return;
		}
		ReplyWrite__submitFormDone = true;
		form.submit();
	}
</script>

<script>
function Reply__delete(id) {
  // AJAX 통신 댓글 삭제
  
  $.post(
    '../reply/doDeleteAjax',
	{
	  id
    },
    
	function(data) {
      if ( data.msg ) alert(data.msg);
      	$(`.reply-tr[data-id="\${id}"]`).remove();    //data-id 속성: 
	},
	'json'
  );
}
</script>

<section class="mt-5">
  <div class="container mx-auto px-3">
    <h1>댓글 작성</h1>

    <c:if test="${rq.logined}">
      <form method="POST" action="../reply/doWrite" onsubmit="ReplyWrite__submitForm(this); return false;">
        <input type="hidden" name="replaceUri" value="${rq.currentUri}" />
        <input type="hidden" name="relTypeCode" value="article" />
        <input type="hidden" name="relId" value="${article.id}" />
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
              <th>내용</th>
              <td class="px-4">
                <textarea class="w-full h-[32rem] textarea textarea-bordered" name="body" rows="5" placeholder="내용"></textarea>
              </td>
            </tr>
          </tbody>
        </table>
        <div>
          <button type="submit" class="btn btn-primary mt-2">댓글작성</button>
        </div>
      </form>
    </c:if>
    <c:if test="${rq.notLogined}">
      <a class="link link-primary" href="${rq.loginUri}">로그인</a> 후 이용해주세요.
    </c:if>
  </div>
</section>
<section class="mt-5">
  <div class="container mx-auto px-3">
    <h1>댓글 목록(${replies.size()})</h1>
    <table class="table table-fixed w-full">
      <colgroup>
        <col width="50" />
        <col width="100" />
        <col width="100" />
        <col width="50" />
        <col width="100" />
        <col width="250" />
        <col />
      </colgroup>
      <thead>
        <tr>
          <th class="text-center">번호</th>
          <th class="text-center">작성날짜</th>
          <th class="text-center">수정날짜</th>
          <th class="text-center">추천</th>
          <th class="text-center">작성자</th>
          <th class="text-center">비고</th>
          <th class="text-center">내용</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="reply" items="${replies}">
          <tr class="align-top reply-tr" data-id="${reply.id}">
            <th>${reply.id}</th>
            <td class="text-center">${reply.forPrintType1RegDate}</td>
            <td class="text-center">${reply.forPrintType1UpdateDate}</td>
            <td class="text-center">${reply.goodReactionPoint}</td>
            <td class="text-center">${reply.extra__writerName}</td>
            <td>
              <c:if test="${reply.extra__actorCanModify}">
                <a class="btn btn-link ml-10" href="../reply/modify?id=${reply.id}&replaceUri=${rq.encodedCurrentUri}">수정</a>
              </c:if>
              <c:if test="${reply.extra__actorCanDelete}">
                <a class="btn btn-link" onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;"
                  href="javascript:Reply__delete(${reply.id})">삭제</a>
              </c:if>
            </td>
            <td class="text-center">${reply.forPrintBody}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <div class="mt-2">
      <a class="btn btn-primary" href="#">맨위로가기</a>
    </div>
  </div>
</section>
<br>
<%@ include file="../common/foot.jspf"%>