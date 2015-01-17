<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
      <head>
        <base href="<%=basePath%>">
        <title>Upload</title>
        <!--装载文件-->
        <link href="uploadify/uploadify.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="uploadify/jquery-1.8.2.js"></script>
       <script type="text/javascript" src="uploadify/jquery.uploadify.js"></script>
        <script type="text/javascript">
      //文件上传
        $(function() {
            $("#uploadify").uploadify({
        //附带值
               'formData':{
                 'userid':'用户id',
                 'username':'用户名',
                 'rnd':'加密密文'
               },
               'auto' : false,
               'method' : "post",
               'height' : '20',
               'width' : '100', 
               'swf': '${pageContext.request.contextPath}/uploadify/uploadify.swf',
               'uploader'      : '${pageContext.request.contextPath}/servlet/upload',
               'fileTypeDesc' : '格式:jpg,png',		//描述
               'fileTypeExts' : '*.jpg;*.png',			//文件类型
               'fileSizeLimit' : '2600KB',			//文件大小
               'buttonText' : '选择文件',			//按钮名称
               'fileObjName'	:'uploadify',
               'successTimeout' : '5',
               'requeueErrors' : false,
               'removeTimeout' : '1',
               'removeCompleted' : false,
               'onFallback':function(){
                   alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
               },
               //上传到服务器，服务器返回相应信息到data里
              'onSelectOnce': function(fileObj)
        {
          /*   alert("唯一标识:" + queueId + "\r\n" +
                  "文件名：" + fileObj.name + "\r\n" +
                  "文件大小：" + fileObj.size + "\r\n" +
                  "创建时间：" + fileObj.creationDate + "\r\n" +
                  "最后修改时间：" + fileObj.modificationDate + "\r\n" +
                  "文件类型：" + fileObj.type
            ); */

        },         
               'onUploadSuccess' : function(file, data, response){
               		var attach = eval('(' + data + ')');
               		$("#fileTable").show();
               		var addHtml = "<tr>"+
               						"<td class='t_l'>"+
               							"<a href='<%=basePath%>/attach/downloadAttach.action?attachId="+attach.id+"'>"+attach.filename+"."+attach.fileextname+"</a>"+
               						"</td>"+
               						"<td class='t_r'>"+attach.filesize+"</td>"+
               						"<td class='t_c'>"+attach.uploaddate+"</td>"+
               		"<td class='t_c'><a href='<%=basePath%>/attach/downloadAttach.action?attachId="+attach.id+"' id='"+attach.id+"'>下载</a></td>"+
               						"<td class='t_c'><a href='#' onclick='removeFile(this)' id='"+attach.id+"' name='attach_id'>取消</a></td>"+
               					  "</tr>";
               		$("#fileBody").append(addHtml);
            	}
        	});
        });
        
        
     /* $("#upload_photo").uploadify({
                //开启调试
                'debug' : false,
                //是否自动上传
                'auto':false,
                //超时时间
                'successTimeout':99999,
                //附带值
                'formData':{
                    'userid':'用户id',
                    'username':'用户名',
                    'rnd':'加密密文'
                },
               'uploader': '/LZKS/Handler/BigFileUpLoadHandler.ashx',
                'swf': '/LZKS/Scripts/uploadify/uploadify.swf',
                'cancelImage': '/LZKS/Scripts/uploadify/cancel.png',
                //flash
                  'cancelImage': '/cancel.png',
              
                'swf': "/uploadify.swf",
                //不执行默认的onSelect事件
                'overrideEvents' : ['onDialogClose'],
                //文件选择后的容器ID
                'queueID':'uploadfileQueue',
                //服务器端脚本使用的文件对象的名称 $_FILES个['upload']
                'fileObjName':'upload',
                //上传处理程序
                'uploader':'/servlet/upload',
                //浏览按钮的背景图片路径
                'buttonImage':'/uploadify-cancel.png',
                //浏览按钮的宽度
                'width':'100',
                //浏览按钮的高度
                'height':'32',
                //在浏览窗口底部的文件类型下拉菜单中显示的文本
                'fileTypeDesc':'支持的格式：',
                //允许上传的文件后缀
                'fileTypeExts':'*.jpg;*.jpge;*.gif;*.png',
                //上传文件的大小限制
                'fileSizeLimit':'3MB',
                //上传数量
                'queueSizeLimit' : 25,
                //每次更新上载的文件的进展
                'onUploadProgress' : function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) {
                     //有时候上传进度什么想自己个性化控制，可以利用这个方法
                     //使用方法见官方说明
                },
                //选择上传文件后调用
                'onSelect' : function(file) {
                          
                },
                //返回一个错误，选择文件的时候触发
                'onSelectError':function(file, errorCode, errorMsg){
                    switch(errorCode) {
                        case -100:
                            alert("上传的文件数量已经超出系统限制的"+$('#file_upload').uploadify('settings','queueSizeLimit')+"个文件！");
                            break;
                        case -110:
                            alert("文件 ["+file.name+"] 大小超出系统限制的"+$('#file_upload').uploadify('settings','fileSizeLimit')+"大小！");
                            break;
                        case -120:
                            alert("文件 ["+file.name+"] 大小异常！");
                            break;
                        case -130:
                            alert("文件 ["+file.name+"] 类型不正确！");
                            break;
                    }
                },
                //检测FLASH失败调用
                'onFallback':function(){
                    alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
                },
                //上传到服务器，服务器返回相应信息到data里
                'onUploadSuccess':function(file, data, response){
                    alert(data);
                }
            }); 
     */
        
        </script>
      </head>
    <body>
        <div id="fileQueue"></div>
      
	<input type="file" name=uploadify id="uploadify" />
	<input type="button" value="上传" onclick="$('#uploadify').uploadify('upload','*');">
	<input type="button" value="取消" onclick="$('#uploadify').uploadify('stop');">
	<table style="display: none;" id="fileTable">
		<tbody style="width: 550px;border: solid;border-color: #D0D0D3;" id="fileBody">
			<tr style="border: solid;border: #D0D0D3;">
				<td width="200px;" class="t_c">文件名</td>
				<td width="100px;" class="t_c">大小(k)</td>
				<td width="150px;" class="t_c">上传时间</td>
				<td width="100px;" class="t_c" colspan="2">操作</td>
			</tr>
		</tbody>
	</table>

    </body>
</html>
