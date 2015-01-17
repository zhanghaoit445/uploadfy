package cn.upload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class upload  extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		
		
				super.doGet(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("lail");

	}

	public Map<String, String> uploadPackage(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	        //使用apache开源组织下的commons-fileupload-1.2.jar组件做文件上传
	        String projectPath = request.getRealPath("/");
	        String tempPath = projectPath + "uploadFile/temp";
	        Map<String, String> params = new HashMap<String, String>();
	        try
	        {
                DiskFileItemFactory factory = new DiskFileItemFactory();
	            //设置文件缓冲区大小
	            factory.setSizeThreshold(1024 * 1024);
	            //超过缓冲区大小，临时文件放在什么地方
	            factory.setRepository(new File(tempPath));
	            
	            //2、使用文件上传工厂，创建一个文件上传的servlet对象；解析表单，保存到list里面
	            ServletFileUpload upload = new ServletFileUpload(factory);
	            //允许上传的大小，以字节为单位
	            upload.setFileSizeMax(1024 * 1024 * 1024);
	            //设置编码格式
	            upload.setHeaderEncoding("UTF-8");
	            // 得到所有的表单域，它们目前都被当作FileItem
	            List<FileItem> items = upload.parseRequest(request);
	            Iterator<FileItem> iter = items.iterator();
	            // 依次处理请求
	            while (iter.hasNext())
	            {
	                FileItem item = iter.next();
	                if (item.isFormField())
	                {    // 如果是普通的表单域
	                    /* "处理普通表单内容 ... */
	                    String name = item.getFieldName();
	                    String value = new String(item.getString().getBytes("ISO-8859-1"), "utf-8");
	                    params.put(name, value);
	                }
	                else
	                { /* 如果是文件上传表单域 */
	                    // 1.获取文件名
	                    String fileName = item.getName();
	                    String fieldName = item.getFieldName();    //文件域名称
	                    String contentType = item.getContentType();    //文件类型
	                    if (fileName != null & !"".equals(fileName))
	                    {    
	                        System.out.println("文件域名称：" + fieldName + "\n文件名：" + fileName + "\n文件类型：" + contentType);
	                        //获取文件后缀名
	                        String suffix = fileName.substring(fileName.lastIndexOf(".")+1);
	                        // 2.先将上传文件保存到本地硬盘上
	                        ServletContext context = this.getServletContext();
	                        String dir = "";
	                        //=======将上传的文件存放到服务器的专门的文件夹下：uploadfile============
	                        Date date = new Date();
	                        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
	                        fileName = sdf.format(date) + fileName;
	                        //这里判断文件类型
	                        //以应用id做为文件夹分类
	                        if("png".equals(suffix) || "jpg".equals(suffix)){
	                            dir = context.getRealPath("uploadFile/photo/");
	                        }
	                        if("mp3".equals(suffix)){
	                            dir = context.getRealPath("uploadFile/music/");
	                        }
	                        
	                        System.out.println(dir);
	                        File file = new File(dir,fileName);
	                        //当且仅当不存在具有此抽象路径名指定名称的文件时，不可分地创建一个新的空文件
	                        file.createNewFile();
	                        // 获得流，读取数据写入文件  
	                        InputStream in = item.getInputStream();  
	                        FileOutputStream fos = new FileOutputStream(file);  
	                        int len = 0;
	                        byte[] buffer = new byte[1024];
	                        // 3.获取本地文件的绝对路径
	                        while ((len = in.read(buffer)) > 0){
	                            fos.write(buffer, 0, len); 
	                        }  
	                        // 关闭资源文件操作  
	                        fos.close();  
	                        in.close();  
	                        // 删除临时文件  
	                        item.delete();  
	                        //new FtpUploadThread(filepath, "handbb_down", fileName).run();
	                        //这里判断是图片还是mp3文件
//	                        if("png".equals(suffix) || "jpg".equals(suffix)){
//	                            photo += fileName + ",";
//	                        }
//	                        
//	                        if("mp3".equals(suffix)){
//	                            music += fileName + ",";
//	                        }
	                        // 7.删除本地文件
	                        //file.delete();
	                    }
	                    else
	                    {// 修改操作时，如果没有上传文件
//	                        if("icon_url".equalsIgnoreCase(fieldName)){
//	                        }
//	                        if("download_url".equalsIgnoreCase(fieldName)){
//	                        }
	                    }
	                }
	            }
	            //params.put("photo", photo);
	            //params.put("music", music);
	        }
	        catch (Exception e)
	        {
	            e.printStackTrace();
	        }
	        return params;
	    }
}
