<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/WEB-INF/jsp/include/tags.jspf" %>
<div class="home-content">
	<div class="content-main">
		<section class="qna-list">
			<h1>최근화제</h1>
			<ul class="list">
			<c:forEach items="${questions.content}" end="4" var="each">
				<li>
					<div class="wrap">
						<div class="main">
							<strong class="subject">
								<a href="/questions/${each.questionId}">${sf:h(each.title)}</a>
							</strong>
							<c:if test="${each.denormalizedTags != ''}">
								<div class="tags">
									<i class="icon-tag" title="태그"></i>
									<span class="tag-list">
										<c:forEach items="${each.denormalizedTags}" var="tag">
											<span class="tag">${tag}</span>
										</c:forEach>
									</span>
								</div>
							</c:if>
							<div class="auth-info">
								<c:choose>
									<c:when test="${each.totalAnswerCount == 0}">
										<i class="icon-new-article"></i>
										<span class="type">새글</span>
										<span class="time">
											<fmt:formatDate value="${each.createdDate}" pattern="yyyy-MM-dd HH:mm" />
										</span>
										<a href="${each.latestParticipant.url}" class="author">${each.latestParticipant.userId}</a>
									</c:when>
									<c:otherwise>
										<i class="icon-add-comment"></i>
										<span class="type">응답</span>
										<span class="time">
											<fmt:formatDate value="${each.updatedDate}" pattern="yyyy-MM-dd HH:mm" />
										</span>
										<a href="${each.latestParticipant.url}" class="author">${each.latestParticipant.userId}</a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="reply" title="댓글">
								<i class="icon-reply"></i>
								<span class="point">${each.totalAnswerCount}</span>
							</div>
						</div>
					</div>
				</li>
			</c:forEach>
			</ul>
			<nav class="link-more">
				<a href="/questions">전체목록보기 &raquo;</a>
			</nav>
		</section>
		<slipp:side-tags tags="${tags}"/>
	</div>
	<div class="content-sub">
		<div class="smalltalk-replyform-fragment">
			<div id="id_commentFormDiv">
				<form class="smalltalk-replyform" id="id_commentForm" name="commentForm" method="post" action="/smalltalks/comments">
					<input type="hidden" name="smallTalkId" id="id_smallTalkId" value=""/>
					<textarea class="tf-smalltalk-form-msg tf-smalltalk-replyform-msg" id="comments" name="comments"></textarea>
					<button class="smalltalk-replyform-submit" type="submit">한마디 보태기</button>
				</form>
			</div>
		</div>
		<section class="smalltalk ui-smalltalk-list-collapse">
			<h1>수다양!</h1>
			<sec:authorize access="hasRole('ROLE_USER')">
				<form action="/smalltalks" class="smalltalk-form">
						<textarea id="smallTalkMessage" name="smallTalkMessage" class="tf-smalltalk-form-msg" style="resize: none"></textarea>
						<label for="smallTalkMessage" class="smalltalk-form-fail-msg error" style="display: none"></label>
						<div class="smalltalk-form-util">
							<p class="smalltalk-form-util-msg"><i class="icon-smalltalk-msg"></i> 요즘 어떠세요?</p>
							<button type="submit" class="btn-smalltalk-form-util-submit">나도 한마디</button>
						</div>
				</form>
			</sec:authorize>
			<ul class='smalltalk-list'></ul>
			<p class="smalltalk-notice">* 최근 10개까지만 보여집니다.</p>
		</section>
		<section class="notice">
			<h1><a href="/wiki/display/slipp/Home">SLiPP log</a></h1>
			<ul class="notice-list">
				<c:forEach items="${pages}" var="page" varStatus="status" end="2">
				<li class="notice-list-item">
					<strong class="notice-item-title"><a href="/wiki/pages/viewpage.action?pageId=${page.pageId}">${page.title}</a></strong>
					<div class="notice-list-item-time">${page.creationDate}</div>
					<c:if test="${status.index == 0}">
						<div class="notice-list-item-cont">${page.shortContents}</div>
					</c:if>
				</li>
				</c:forEach>
			</ul>
			<div class="rss">
				<a href="http://dev.naver.com/d2" target="_blank"><img src="${url:resource('/images/banner_d2.png')}" width="96" height="32" border="0"></a>
				<a href="http://www.atlassian.com/" target="_blank"><img src="${url:resource('/images/banner_atlassian.jpg')}" width="96" height="32" border="0"></a>
			</div>
		</section>
	</div>
</div>
<script src="${url:resource('/javascripts/jquery.tmpl.min.js')}"></script>
<script src="${url:resource('/javascripts/main/smalltalk.js')}"></script>
<script src="${url:resource('/javascripts/main/smalltalkcomment.js')}"></script>
<script type="text/javascript">
	$(document).ready(function(){
		smalltalkService.init();
		commentService.init();
	});
</script>
