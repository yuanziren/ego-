package com.ego.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 商品分类COntroller
 */
@Controller
@RequestMapping("/product")
public class ProductController {


    /**
     * 商品分类列表页
     * @return
     */
    @RequestMapping("/category/list")
    public String categoryList(){
        return "product/category/category-list";
    }

    /**
     * 商品添加新增页
     * @return
     */
    @RequestMapping("/category/add")
    public String categoryAdd(){
        return "product/category/category-add";
    }

}
