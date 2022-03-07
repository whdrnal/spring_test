<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX연습연결 연습장</title>
<style>
.rs {
	border: 10px dotted black;
	padding: 30px;
	font-size: 3rem;
}

.rs-msg {
	margin-top: 10px;
	border: 10px dotted pink;
	padding: 30px;
	font-size: 3rem;
}

.rs-code {
  margin-top: 10px;
  border: 10px dotted gold;
  padding: 30px;
  font-size: 3rem;
}
</style>

<!-- J쿼리 사용 AJAX -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<script>
  function callByAjaxV1() {
    var form = document.form1;
    var num1 = form.num1.value;
    var num2 = form.num2.value;
   
    var action = form.action;
    
	$.get(
		'./doPlus',
		{
			num1: num1,
			num2: num2
		},
		function(data) {
			$('.rs').empty().append(data);
		},
		'html'
	);
  }
 
/* 메세지 ajax */
  function callByAjaxV2() {
	    var form = document.form1;

	    var num1 = form.num1.value;
	    var num2 = form.num2.value;
	   
	    var action = form.action;
	    
		$.get(
			'./doPlus',
			{
				num1: num1,
				num2: num2
			},
			function(data) {
				data = data.split('/');
				var rs = data[0];
				var msg = data[1];
				var code = data[2];
				
				$('.rs').text(rs);
				$('.rs-msg').text(msg);
				$('.rs-code').text(code);
			},
			'html'
		);
	  }
/* Map 으로 호출 ajax */ 
/* 메세지 ajax */
  function callByAjaxV3() {
	    var form = document.form1;

	    var num1 = form.num1.value;
	    var num2 = form.num2.value;
	    
		$.get(
			'./doPlusJson',
			{
				num1: num1,
				num2: num2
			},
			function(data) {			
				$('.rs').text(data.rs);
				$('.rs-msg').text(data.msg);
				$('.rs-code').text(data.code);
			},
			'json'
		);
	  }
	  
</script>
</head>

<body>
  <h1>AJAX 더하기 폼</h1>
  <form name="form1" action="./doPlus" method="GET">
    <div>
      <input type="text" name="num1" placeholder="숫자1" />
    </div>
    <div>
      <input type="text" name="num2" placeholder="숫자2" />
    </div>
    <div>
      <input type="submit" value="더하기" />
    </div>
    <div>
      <input onclick="callByAjaxV1();" type="button" value="더하기v1" />
      <input onclick="callByAjaxV2();" type="button" value="더하기v2" />
      <input onclick="callByAjaxV3();" type="button" value="더하기v3(json)" />
    </div>
  </form>

  <h2>결과 값</h2>
  <div class="rs"></div>
  <h2>결과 메세지</h2>
  <div class="rs-msg"></div>
  <h2>더하기 결과 코드</h2>
  <div class="rs-code"></div>
</body>
</html>