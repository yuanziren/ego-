package com.ego.util;
import java.io.IOException;
import java.util.List;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
/**
* @see(功能介绍) : Json 转换工具类
* @version(版本号) : 1.0
* @author(创建人) : Dylan
* @since : JDK 1.8
*/
public class JsonUtil {
 private static ObjectMapper objectMapper = new ObjectMapper();
 /**
 * 将对象转换成 json 字符串
 *
 * @param obj
 * @return
 */
 public static String object2JsonStr(Object obj) {
 try {
 return objectMapper.writeValueAsString(obj);
 } catch (JsonProcessingException e) {
 //打印异常信息
 e.printStackTrace();
 }
 return null;
 }
 /**
 * 将字符串转换为对象
 *
 * @param <T> 泛型
 */
 public static <T> T jsonStr2Object(String jsonStr, Class<T> clazz) {
 try {
 return objectMapper.readValue(jsonStr.getBytes("UTF-8"), clazz);
 } catch (JsonParseException e) {
 e.printStackTrace();
 } catch (JsonMappingException e) {
 e.printStackTrace();
 } catch (IOException e) {
 e.printStackTrace();
 }
 return null;
 }
 /**
 * 将 json 数据转换成 pojo 对象 list
 * <p>Title: jsonToList</p>
 * <p>Description: </p>
 *
 * @param jsonStr
 * @param beanType
 * @return
 */
 public static <T> List<T> jsonToList(String jsonStr, Class<T> beanType) {
 JavaType javaType = 
objectMapper.getTypeFactory().constructParametricType(List.class, beanType);
 try {
 List<T> list = objectMapper.readValue(jsonStr, javaType);
 return list;
 } catch (Exception e) {
 e.printStackTrace();
 }
 return null;
 }
}