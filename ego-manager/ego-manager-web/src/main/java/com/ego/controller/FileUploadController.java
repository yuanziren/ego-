package com.ego.controller;

import com.ego.result.FileResult;
import com.ego.service.FileUploadServiceI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
@RequestMapping("/fileUpload")
public class FileUploadController {


    private static Logger logger = LoggerFactory.getLogger(FileUploadController.class);

    @Autowired
    private FileUploadServiceI fileUploadServiceI;

    @RequestMapping("/save")
    @ResponseBody
    public FileResult fileUploadSave(MultipartFile file) {

        try {
            return fileUploadServiceI.fileUplpad(file.getOriginalFilename(),file.getInputStream());
        } catch (IOException e) {
            logger.error("文件上传失败，失败原因：" + e.getMessage());
        }
        return null;
    }
}
