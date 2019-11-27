<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
  <head>
      <!-- 静态引用-->
       <%@include file="../../head.jsp" %>

      <link rel="stylesheet" href="${ctx }/Public/css/fileinput.min.css"></link>
      <script type="text/javascript" src="${ctx }/Public/js/fileinput.js"></script>
      <!-- 对中文的支持 -->
      <script type="text/javascript" src="${ctx }/Public/js/fileinput_locale_zh.js"></script>

    <script type="text/javascript">
    function delfunc(obj){
    	layer.confirm('确认删除？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
   				$.ajax({
   					type : 'post',
   					url : $(obj).attr('data-url'),
   					data : {act:'del',del_id:$(obj).attr('data-id')},
   					dataType : 'json',
   					success : function(data){
   						if(data==1){
   							layer.msg('操作成功', {icon: 1});
   							$(obj).parent().parent().remove();
   						}else{
   							layer.msg(data, {icon: 2,time: 2000});
   						}
   						layer.closeAll();
   					}
   				})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);
    }
    
    //全选
    function selectAll(name,obj){
    	$('input[name*='+name+']').prop('checked', $(obj).checked);
    }   
    
    function get_help(obj){
        layer.open({
            type: 2,
            title: '帮助手册',
            shadeClose: true,
            shade: 0.3,
            area: ['90%', '90%'],
            content: $(obj).attr('data-url'), 
        });
    }
    
    function delAll(obj,name){
    	var a = [];
    	$('input[name*='+name+']').each(function(i,o){
    		if($(o).is(':checked')){
    			a.push($(o).val());
    		}
    	})
    	if(a.length == 0){
    		layer.alert('请选择删除项', {icon: 2});
    		return;
    	}
    	layer.confirm('确认删除？', {btn: ['确定','取消'] }, function(){
    			$.ajax({
    				type : 'get',
    				url : $(obj).attr('data-url'),
    				data : {act:'del',del_id:a},
    				dataType : 'json',
    				success : function(data){
    					if(data == 1){
    						layer.msg('操作成功', {icon: 1});
    						$('input[name*='+name+']').each(function(i,o){
    							if($(o).is(':checked')){
    								$(o).parent().parent().remove();
    							}
    						})
    					}else{
    						layer.msg(data, {icon: 2,time: 2000});
    					}
    					layer.closeAll();
    				}
    			})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);	
    }
    </script>        
  <meta name="__hash__" content="3089b9badfca8307d7d520487d125ae4_6385f66dff50b4c04db3ec79b8a9d245" /></head>
  <body style="background-color:#ecf0f5;">
 

<div class="wrapper">
    <div class="breadcrumbs" id="breadcrumbs">
	<ol class="breadcrumb">
	<li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>
	        
	        <li><a href="javascript:void();">商品管理</a></li>    
	        <li><a href="javascript:void();">添加修改分类</a></li>          
	</ol>
</div>

		<section class="content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">增加分类</h3>
			                <div class="pull-right">
			                	<a href="${ctx}/product/category/list" data-toggle="tooltip" title="" class="btn btn-default" data-original-title="返回"><i class="fa fa-reply"></i></a>
			                	<a href="javascript:;" class="btn btn-default" data-url="http://www.ego.cn/Doc/Index/article/id/1006/developer/user.html" onclick="get_help(this)"><i class="fa fa-question-circle"></i> 帮助</a>
			                </div>
                        </div>
 
                        <!-- /.box-header -->
                        <form  class="form-horizontal" id="category_form">
                        <div class="box-body">                         
                                <div class="form-group">
                                     <label class="col-sm-2 control-label">分类名称</label>
                                     <div class="col-sm-6">
                                        <input type="text" placeholder="名称" class="form-control large" name="name" value="">
                                        <span class="help-inline" style="color:#F00; display:none;" id="err_name"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">手机分类名称</label>
                                    <div class="col-sm-6">
                                        <input type="text" placeholder="手机分类名称" class="form-control large" name="mobileName" value="">
                                        <span class="help-inline" style="color:#F00; display:none;" id="err_mobile_name"></span>
                                    </div>
                                </div>

                                <input name="parentId" id="parentId" value=""/>
                                <input name="level" id="level" />
                                <div class="form-group">
                                    <label0 class="control-label col-sm-2">上级分类</label0>

                                    <div class="col-sm-3">
                                        <select name="parent_id_1" id="parent_id_1"
                                                onchange="get_category(this.value,'parent_id_2','0');" class="small form-control">
	                                        <option value="0">顶级分类</option>
                                            <c:forEach var="gc" items="${gcList}">
                                                <option value="${gc.id}">${gc.name}</option>
                                            </c:forEach>
										</select>
                                    </div>                                    
                                    <div class="col-sm-3">
                                      <select name="parent_id_2" id="parent_id_2"  class="small form-control"
                                      onchange="setHiddenValue(this.value)">
                                        <option value="0">请选择商品分类</option>
                                      </select>  
                                    </div>                                      
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2">导航显示</label>
									
                                    <div class="col-sm-10">
                                        <label> 
                                            <input checked="checked" type="radio" name="isShow" value="1"> 是
                                                <input type="radio" name="isShow" value="0"> 否
                                                                                                                                                                                
                                        </label>
                                    </div>
                                </div>
				<div class="form-group">
                                    <label class="control-label col-sm-2">分类分组:</label>
									
                                    <div class="col-sm-1">
                                      <select name="catGroup" id="cat_group" class="form-control">
                                        <option value="0">0</option>                                        
                                        <option value='1' >1</option>"
                                        <option value='2' >2</option>"
                                        <option value='3' >3</option>"
                                        <option value='4' >4</option>"
                                        <option value='5' >5</option>"
                                        <option value='6' >6</option>"
                                        <option value='7' >7</option>"
                                        <option value='8' >8</option>"
                                        <option value='9' >9</option>"
                                        <option value='10' >10</option>"
                                        <option value='11' >11</option>"
                                        <option value='12' >12</option>"
                                        <option value='13' >13</option>"
                                        <option value='14' >14</option>"
                                        <option value='15' >15</option>"
                                        <option value='16' >16</option>"
                                        <option value='17' >17</option>"
                                        <option value='18' >18</option>"
                                        <option value='19' >19</option>"
                                        <option value='20' >20</option>"
                                      </select>                                        
                                    </div>                                    
                                </div>   
                             
				  <div class="form-group">
                                    <input id="image" name="image" type="hidden"/>
                                    <label class="control-label col-sm-2">分类展示图片</label>

                                    <div class="col-sm-10">
                                        <form enctype="multipart/form-data">                                          <!--multiple 上传多张图片-->
                                            <input id="file-product-category" class="file" name="file" type="file" multiple data-min-file-count="1">
                                        </form>
                                    </div>
                                </div>                                
                               <div class="form-group">
                                    <label class="control-label col-sm-2">显示排序</label>
                                    <div class="col-sm-1">
                                        <input type="text" placeholder="50" class="form-control large" name="so rtOrder" value=""/>
                                        <span class="help-inline" style="color:#F00; display:none;" id="err_sort_order"></span>
                                    </div>
                                </div>
								<div class="form-group">
                                    <label class="control-label col-sm-2">分佣比例</label>
                                    <div class="col-sm-1">
                                        <input type="text" placeholder="50" class="form-control large" name="commissionRate" id="commission_rate" value="0" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"/>
                                    </div>
                                    <div class="col-sm-1" style="margin-top: 6px;margin-left: -20px;">
                                        <span>%</span> 
                                    </div>
                                </div>                                								                                                               
                        </div>
                        <div class="box-footer">                        	
                            <input type="hidden" name="id" value="">                           
                        	<button type="reset" class="btn btn-primary pull-left"><i class="icon-ok"></i>重填  </button>                       	                 
                            <button type="button" onclick="ajax_submit_form('category_form');"
                                                     class="btn btn-primary pull-right"><i class="icon-ok"></i>提交  </button>
                        </div> 
                        <input type="hidden" name="__hash__" value="3089b9badfca8307d7d520487d125ae4_6385f66dff50b4c04db3ec79b8a9d245" /></form>
                    </div>
                </div>
            </div>
        </section>
</div>
<script>  
    
/** 以下是编辑时默认选中某个商品分类*/
$(document).ready(function(){
		 
		
});

//文件上传插件
/**
 * 初始设置
 * language指定语言
 * uploadUrl指定文件上传的后台地址
 * allowedPreviewTypes允许上传文件的类型
 */
$('#file-product-category').fileinput({
    language: 'zh',
    uploadUrl: '${ctx}/fileupload/save',
    allowedPreviewTypes : ['image', 'html', 'text', 'video', 'audio', 'flash']
});
/**
 * 上传文件失败后 调用方法（回调函数）
 */
$('#file-product-category').on('fileuploaderror', function(event, data,
                                                           previewId, index) {
    var form = data.form,
        files = data.files, e
    xtra = data.extra,
        response = data.response,
        reader = data.reader;

    console.log(data);
    console.log('File upload error');
});
/**
 * 文件错误 比如文件类型错误 调用方法（回调函数）
 */
$('#file-product-category').on('fileerror', function(event, data) {
    console.log(data.id);
    console.log(data.index);
    console.log(data.file);
    console.log(data.reader);
    console.log(data.files);
});
/**
 * 文件上传成功后 调用方法（回调函数）
 */
$('#file-product-category').on('fileuploaded', function(event, data, previewId,
                                                        index) {
    var form = data.form,
        files = data.files,
        extra = data.extra,
        response = data.response,
        reader = data.reader;
    // 服务器文件地址
   // alert(data.response.fileUrl);
    //将服务器文件地址设置到隐藏域
    $("#image").val(data.response.fileUrl);
   // console.log('File uploaded triggered');
});

    function get_category(thisValue,nextId) {
        //测试onchange是否有效
        //alert(thisValue);

        var html ="<option value='0'>请选择商品分类</option>";
        //如果thisValue是0
        if(0==thisValue){
            $("#parentId").val(0);
            $("#level").val(1);
            $("#" + nextId).html(html);
            return;
        }

        //设置隐藏域的值
        $("#parentId").val(thisValue);
        $("#level").val(2);

        //发送ajax请求，目的：根据顶级分类id查询下级分类
        $.ajax({
            //rsultful类型的路径
            url:"${ctx}/product/category/"+thisValue,
            type:"GET",
            dataType:"JSON",
            success:function(result){
                console.log(result);
                //var一个字符串，用于拼接HTML语句

                for(var i=0;i<result.length;i++){
                    //拼接语句
                    html+="<option value="+result[i].id+">"+result[i].name+"</option>";
                }
                //通过id定位到二级下拉框，执行HTML语句
                //$("#")是对id进行操作
                $("#"+nextId).html(html);
            },
            error:function(result){

            }

        });

    }
//查询完下级目录后,再次更改等级
function setHiddenValue(thisValue){
    //如果thisValue是0
    if(0==thisValue){
        //如果没有选择二级分类,则新增类型的父类还是一级的
        $("#parentId").val($("#parent_id_1").val());
        $("#level").val(2);
        return;
    }
    //如果选择了二级分类,则新增类型的父类变为二级分类
    $("#parentId").val(thisValue);
    $("#level").val(3);
}

function ajax_submit_form(formId){
    $.ajax({
        url:"${ctx}/product/category/save",
        type:"POST",
        //.serialize(),将form表单中所有那么域名称对应的值全都搜集到一起,
        // 传至后台后,与域名对应的JavaBean属性值就能获取到,由Spring框架完成
        data:$("#"+formId).serialize(),
        dataTYpe:"JSON",
        success:function(result){
            if(200==result.code){
                //弹窗
                layer.confirm('保存成功！', {btn: ['继续新增', '返回列表']},
                    function () {
                        window.location.href = "${ctx}/product/category/add";
                    }, function () {
                        window.location.href = "${ctx}/product/category/list";
                    });
            } else {
                layer.alert("亲，系统正在升级中，请稍后再试！");
            }
        },
        error: function (result) {
            layer.alert("亲，系统正在升级中，请稍后再试！");
        }
    });
}
</script>
   
</body>
</html>