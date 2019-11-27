package com.ego.service;

import com.ego.result.FileResult;

import java.io.InputStream;

public interface FileUploadServiceI {

    /**
     * 文件上传
     *
     * @return
     */
    FileResult fileUplpad(String fileName, InputStream is);


}