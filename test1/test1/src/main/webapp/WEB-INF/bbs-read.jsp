<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<link rel="stylesheet" href="css/style.css">
	<title>Insert title here</title>
</head>
<style>
	
</style>
<body>
	<div id="app">
		<div class="container">
			<div class="card">
				<h3 class="card-header p-4">
					{{info.title}}
					<span class="badge badge-pill badge-dark pull-right" style="float: right;">{{info.cdatetime}}</span>
					<span>조회수  :  {{info.cnt}}</span>
					
				</h3>
				<div class="card-body">
				   	<div style="margin: 10px 10px 10px 10px;">
				   		{{info.content}}
				   	</div>
			   	</div>
			</div>
			<button @click="fnList" class="btn" style="float: right;">목록으로</button>
			<button @click="fnUpdate" class="btn" style="float: right;">수정</button>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
var app = new Vue({ 
    el: '#app',
    data: {
       list : [] 
       , info : {}
       , boardKey : "${map.boardKey}"	// bbs-list 에 boardKey 를 가져옴 
    }   
    , methods: {
    	
    	fnList : function(){
    		location.href="/bbs.do";
    	}
    
    	,
    	fnUpdate : function(){
    		var self = this;
    		self.pageChange("/modify.do" , {boardKey : self.boardKey});
    	}
    	,
	    fnGetBoard : function(){
	        var self = this;
	        var nparmap = {boardKey : self.boardKey};
	        $.ajax({
	            url:"/bbs/read.dox",
	            dataType:"json",	
	            type : "POST", 
	            data : nparmap,
	            success : function(data) {
	            	console.log();                                       
	                self.info = data.board;
	            }
	        }); 
	    }
    	
    	, pageChange : function(url, param) {
    		var target = "_self";
    		if(param == undefined){
    		//	this.linkCall(url);
    			return;
    		}
    		var form = document.createElement("form"); 
    		form.name = "dataform";
    		form.action = url;
    		form.method = "post";
    		form.target = target;
    		for(var name in param){
				var item = name;
				var val = "";
				if(param[name] instanceof Object){
					val = JSON.stringify(param[name]);
				} else {
					val = param[name];
				}
				var input = document.createElement("input");
	    		input.type = "hidden";
	    		input.name = item;
	    		input.value = val;
	    		form.insertBefore(input, null);
			}
    		document.body.appendChild(form);
    		form.submit();
    		document.body.removeChild(form);
    	}
    
    }   
    , created: function () {		// 페이지 로드될때 바로 실행됨
    	var self = this;
    	self.fnGetBoard();
	}
});
</script>