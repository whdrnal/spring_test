<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="" />
<%@ include file="../common/head.jspf"%>
<head>
<meta charset="utf-8">

<style media="screen">
#divClock {
  margin-top: 210px;
  font-size: 30px;
  color: #8F7CEE;
  text-align: center;
  box-shadow: 5px 5px 10px ;
}
</style>

<script type="text/javascript">
	function showClock() {
		var currentDate = new Date();
		var divClock = document.getElementById('divClock');
		var msg = "";
		if (currentDate.getHours() > 12) { //시간이 12보다 크다면 오후 아니면 오전
			msg += "오후 ";
			msg += currentDate.getHours() - 12 + "시 ";
		} else {
			msg += "오전 ";
			msg += currentDate.getHours() + "시 ";
		}

		msg += currentDate.getMinutes() + "분 ";
		msg += currentDate.getSeconds() + "초";

		divClock.innerText = msg;

		if (currentDate.getMinutes() > 58) { //정각 1분전부터 빨강색으로 출력
			divClock.style.color = "red";
		}
		setTimeout(showClock, 1000); //1초마다 갱신
	}
</script>
</head>
<body onload="showClock()">
  <div id="divClock" class="clock"></div>
</body>

<!-- 소개 html ↓ -->
<section class="mt-5">
  <div class="container mx-auto">
    <div class="text-center" style="font-size:2rem;">
<%--       <center>
        <img class="img" src="https://ifh.cc/g/j13moR.png" />
      </center> --%>
      <div class="mt-10">
      <span>𝑰 𝒏𝒆𝒗𝒆𝒓 𝒅𝒓𝒆𝒂𝒎𝒆𝒅 𝒂𝒃𝒐𝒖𝒕 𝒔𝒖𝒄𝒄𝒆𝒔𝒔, 𝑰 𝒘𝒐𝒓𝒌𝒆𝒅 𝒇𝒐𝒓 𝒊𝒕.</span>
      </div>
    </div>
  </div>
</section>

<%@ include file="../common/foot.jspf"%>