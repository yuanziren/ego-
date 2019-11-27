package com.ego.service.impl;

import com.ego.result.FileResult;
import com.ego.service.FileUploadServiceI;
import com.ego.util.DateUtil;
import com.ego.util.FTPUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.time.LocalDateTime;

@Service
public class FileUploadServiceImpl implements FileUploadServiceI {


    @Value("${ftp.host}")
    private String host;
    @Value("${ftp.port}")
    private Integer port;
    @Value("${ftp.hostname}")
    private String hostname;
    @Value("${ftp.password}")
    private String password;
    @Value("${ftp.path}")
    private String basePath;

    public FileUploadServiceImpl() {
    }

    @Override
    public FileResult fileUplpad(String fileName, InputStream is) {

        FileResult fileResult = null;
        // 拼接上传路径 格式：/home/ftpuser/ego/2019/05/06
        String dataStr = DateUtil.getDateStr(LocalDateTime.now(), DateUtil.pattern_date);
        String path = basePath + dataStr;
        // 接收返回的文件名
        String newFileName = FTPUtil.fileUpload(host, port, hostname, password, path, fileName, is);
        if (null != newFileName && newFileName.length() > 0) {
            fileResult = new FileResult();
            fileResult.setSuccess("success");
            fileResult.setMessage("文件上传成功！");
            // http://192.168.10.26/2019/05/06/x.jpg
            String dbPath = "http://" + host + "/" + dataStr + "/" + newFileName;
            fileResult.setFileUrl(dbPath);
        }
        return fileResult;
    }
}
