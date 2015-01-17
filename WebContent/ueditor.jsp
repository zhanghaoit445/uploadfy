<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>Upload</title>
<!--装载文件-->
<link href="ueditor/themes/default/css/ueditor.css" rel="stylesheet"
	type="text/css" />
<script src=" uploadify/jquery-1.8.2.js"></script>
<script src="ueditor/ueditor.config.js"></script>
<script src="ueditor/ueditor.all.min.js"></script>
<script src="ueditor/lang/zh-cn/zh-cn.js"></script>
<!-- 上传js 结束 -->

<script src="booklet/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="booklet/jquery.booklet.1.1.0.min.js" type="text/javascript"></script>
<link href="booklet/jquery.booklet.1.1.0.css" type="text/css" rel="stylesheet" media="screen" />
<link rel="stylesheet" href="booklet/style.css" type="text/css" media="screen" />

<!-- 图片展示js结束 -->

<script type="text/javascript">
	//重新实例化一个编辑器，防止在上面的editor编辑器中显示上传的图片或者文件
	var _editor = UE.getEditor('upload_ue');
	_editor.ready(function() {
				//设置编辑器不可用
//隐藏编辑器，因为不会用到这个编辑器实例，所以要隐藏
			_editor.hide();
	
				//侦听图片上传
				_editor.addListener(
								'beforeinsertimage',
								function(t, posx) {
								
                    var imglist=$("#showimg").find("img");//获取ID为div里面的所有img
                   
    				$("#showimg").empty();//首先清空已经存在的图片
    				var  addhtml=" ";
    				  for(var i=0;i<imglist.length;i++){ //循环老的img设置 并且重新添加到html
    					    addhtml = addhtml+  " <div>"
							+ "<img style='width:300px;height:200px'"+" id=image"+i+"  src="+imglist[i].src+">"
							+ "<h1>标题</h1>"
							+ "<textarea style='width:370px;height:100px;max-width:400px;max-height:100px;'></textarea>"
							+ "<a href="+imglist[i].src+" target='_blank' class='article'>下载</a>"
							+ "<a href="+imglist[i].src+" target='_blank' class='demo'>预览</a></div>";
                     
                      }
    				   //$("#showimg").append(addhtml);//再次添加

                    /* 
                	var imglist=$("#showimg").find("img").html();
                	alert(imglist); */
					/* for (var int = 0; int < imglist.length; int++) {
					   alert(imglist[i].src);
					} */
				for (var i = 0; i < posx.length; i++) {//添加新的img到html
                           addhtml =  addhtml+ " <div>"
												+ "<img style='width:300px;height:200px'"+" id=image"+i+"  src="+posx[i].src+">"
												+ "<h1>标题</h1>"
												+ "<textarea style='width:370px;height:100px;max-width:400px;max-height:100px;'></textarea>"
												+ "<a href="+posx[i].src+" target='_blank' class='article'>下载</a>"
												+ "<a href="+posx[i].src+" target='_blank' class='demo'>预览</a></div>";
								}

					$("#showimg").append(addhtml);//再次添加

					
									loadimg();

									//    $("#picture").attr("value", arg[0].src);
									//图片预览
									//将地址赋值给相应的input

								})

			});
	//弹出图片上传的对话框
	function upImage() {
		var myImage = _editor.getDialog("insertimage");
		myImage.open();
	}
	function loadimg() {
		var $mybook = $('#mybook');
		var $bttn_next = $('#next_page_button');
		var $bttn_prev = $('#prev_page_button');
		var $loading = $('#loading');
		var $mybook_images = $mybook.find('img');
		var cnt_images = $mybook_images.length;
		    $loading.toggle();
		var loaded			= 0;
		$mybook_images.each(function() {
			var $img = $(this);
			var source = $img.attr('src');
			$('<img/>').load(function() {
				++loaded;
					if(loaded == cnt_images){
				$loading.hide();
				$bttn_next.show();
				$bttn_prev.show();
				$mybook.show().booklet({
					name : null, // name of the booklet to display in the document title bar
					width : 800, // container width
					height : 500, // container height
					speed : 600, // speed of the transition between pages
					direction : 'LTR', // direction of the overall content organization, default LTR, left to right, can be RTL for languages which read right to left
					startingPage : 0, // index of the first page to be displayed
					easing : 'easeInOutQuad', // easing method for complete transition
					easeIn : 'easeInQuad', // easing method for first half of transition
					easeOut : 'easeOutQuad', // easing method for second half of transition

					closed : true, // start with the book "closed", will add empty pages to beginning and end of book
					closedFrontTitle : null, // used with "closed", "menu" and "pageSelector", determines title of blank starting page
					closedFrontChapter : null, // used with "closed", "menu" and "chapterSelector", determines chapter name of blank starting page
					closedBackTitle : null, // used with "closed", "menu" and "pageSelector", determines chapter name of blank ending page
					closedBackChapter : null, // used with "closed", "menu" and "chapterSelector", determines chapter name of blank ending page
					covers : false, // used with  "closed", makes first and last pages into covers, without page numbers (if enabled)

					pagePadding : 10, // padding for each page wrapper
					pageNumbers : true, // display page numbers on each page

					hovers : true, // enables preview pageturn hover animation, shows a small preview of previous or next page on hover
					overlays : false, // enables navigation using a page sized overlay, when enabled links inside the content will not be clickable
					tabs : false, // adds tabs along the top of the pages
					tabWidth : 60, // set the width of the tabs
					tabHeight : 20, // set the height of the tabs
					arrows : false, // adds arrows overlayed over the book edges
					cursor : 'pointer', // cursor css setting for side bar areas

					hash : false, // enables navigation using a hash string, ex: #/page/1 for page 1, will affect all booklets with 'hash' enabled
					keyboard : true, // enables navigation with arrow keys (left: previous, right: next)
					next : $bttn_next, // selector for element to use as click trigger for next page
					prev : $bttn_prev, // selector for element to use as click trigger for previous page

					menu : null, // selector for element to use as the menu area, required for 'pageSelector'
					pageSelector : false, // enables navigation with a dropdown menu of pages, requires 'menu'
					chapterSelector : false, // enables navigation with a dropdown menu of chapters, determined by the "rel" attribute, requires 'menu'

					shadows : true, // display shadows on page animations
					shadowTopFwdWidth : 166, // shadow width for top forward anim
					shadowTopBackWidth : 166, // shadow width for top back anim
					shadowBtmWidth : 50, // shadow width for bottom shadow

					before : function() {
					}, // callback invoked before each page turn animation
					after : function() {
					} // callback invoked after each page turn animation
				});
				
					}}).attr('src', source);
		});

	};
</script>
<script type="text/javascript">


</script>
</head>
<body>
	<div id="fileQueue"></div>
	<span>图片：</span>
	<input type="text" id="picture" name="cover" />
	<a href="javascript:void(0);" onclick="upImage();">上传图片</a>

	<script type="text/plain" id="upload_ue"></script>


	<div id="image"></div>

	<!--图片展示 开始  -->
	<div class="book_wrapper">
		<a id="next_page_button"></a>
	    <a id="prev_page_button"></a>
	    
			<div id="loading" class="loading">加载中</div>
	    <div id="mybook" style="display: none;">
		<div class="b-load" id="showimg">
			</div>
		</div>
	</div>

	<!--图片展示 结束  -->











</body>
</html>
