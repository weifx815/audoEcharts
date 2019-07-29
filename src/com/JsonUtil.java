package com;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
/**
 * JSON转换工具类
 * @author wfx
 * 描述：涉及JSON转换方法在这里写
 */
public class JsonUtil {
	/**
	 * String转换为JSONObject对象
	 * @return JSONObject
	 */
	public static JSONObject StringToJson(String jsonstr) {
		JSONObject json = JSONObject.fromObject(jsonstr);
		return json;
	}
	/**
	 * JSON转换为Map对象
	 * @return Map<String, String>
	 */
	@SuppressWarnings({ "unchecked"})
	public static Map<String, Object> jsonToMap(String jsonstr){
		Map<String, Object> map = (Map<String, Object>) net.sf.json.JSONObject.fromObject(jsonstr);  
		return map;
	}
	/**
	 * JSON转换为Map对象
	 * @return Map<String, String>
	 */
	public static Map<String, Object> JsontoMap(JSONObject jsonObject) {
        Map<String, Object> result = new HashMap<String, Object>();
        Iterator<String> iterator = jsonObject.keys();
        String key = null;
        String value = null;
        while (iterator.hasNext()) {
            key = iterator.next();
            value = jsonObject.getString(key);
            result.put(key, value);
        }
        return result;
    }



	/**
	 * Map对象转换为String
	 * @return String
	 */
	public static String MapToString(Map<String, String> map) {
		JSONObject json = JSONObject.fromObject(map);
		return json.toString();
	}
	/**
	 * Map对象转换为JSON
	 * @return JSONObject
	 */
	public static JSONObject MapToJson(Map<String, String> map) {
		JSONObject json = JSONObject.fromObject(map);
		return json;
	}
	/**
	 * Map对象转换为JSON
	 * @return JSONObject
	 */
	public static JSONObject MapObjToJson(Map<String, Object> map) {
		JSONObject json = JSONObject.fromObject(map);
		return json;
	}
	/**
     * List<T> 转 json 
     * @return <T>String
     */
    public static <T> String listToJson(List<T> ts) {
        String jsons = JSON.toJSONString(ts);
        return jsons;
    }
    /**
     * json 转 List<T>
     * "{{\"0\":\"zhangsan\",\"1\":\"lisi\",\"2\":\"wangwu\",\"3\":\"maliu\"},"  
     * "{\"00\":\"zhangsan\",\"11\":\"lisi\",\"22\":\"wangwu\",\"33\":\"maliu\"}}"
     * @return <T> List<T>
     */
    public static <T> List<T> jsonToListOfT(String jsonString, Class<T> clazz) {
        List<T> listT = (List<T>) JSONArray.parseArray(jsonString, clazz);
        return listT;
    }
    /**
     * json 转 List<Map<String,String>>
     * "{{\"0\":\"zhangsan\",\"1\":\"lisi\",\"2\":\"wangwu\",\"3\":\"maliu\"},"  
     * "{\"00\":\"zhangsan\",\"11\":\"lisi\",\"22\":\"wangwu\",\"33\":\"maliu\"}}"
     * @return <T> List<Map<String,String>>
     */
	public static <T> List<Map<String,Object>> jsonToListOfMap(String jsonString, Class<T> clazz) {
    	List<Map<String,Object>> listMap = (List<Map<String,Object>>) JSONArray.parseArray(jsonString, clazz);
        return listMap;
    }
	/**
	 * 根据固定JSON串判断是Map对象或者List对象或者String
	 * @param JSON串 
	 * @return L=list对象 M=map对象 S=String类
	 */
    public static String isMapOrListOrString(String json) {
    	if(json.startsWith("[{") && json.endsWith("}]")){ 
    		return "L";
		}else if(json.startsWith("{") && json.endsWith("}")){
			return "M";
		}else if("[]".equals(json)){
			return "NL";
		}else{
			return "S";
		}
    }
    /**
	 * 根据固定JSON串，json目录级别，获取类型 返回对象
	 * @param postdata JSON串 
	 * @param live 以冒号隔开的级别串 例如： postdata:formdata:selfmadeformdata:scdz
	 * @return Object（List or Map or String）
	 */
    public static Object getJsonObject(String postdata,String live) {
    	Map<String, Object> map = JsontoMap(StringToJson(postdata));
    	List<Map<String,Object>> list = new ArrayList<Map<String, Object>>();
    	String[] lives = live.split(":");
    	if(lives.length==1){
    		return map;
    	}
    	for (int i = 1; i < lives.length; i++) {
    		String liveType = lives[i];
    		String str = map.get(liveType)+"";
    		if("M".equals(isMapOrListOrString(str))){
    			map = JsontoMap(StringToJson(str));
    		}else if("L".equals(isMapOrListOrString(str))){
    			list = jsonToListOfMap(str, Map.class);
    		}else if("NL".equals(isMapOrListOrString(str))){
    			return list;
    		}else{
    			return str;
    		}
    	}
    	Object obj = list.size()>0?list:map;
    	return obj;
    }
    /**
     * @param args
     */
    public static void main(String[] args) {
    	String live = "postdata:formdata:selfmadeformdata:scdz";
    	String postdata="{\"userid\": \"11\",\"userinfo\": {\"incname\": \"企业名称\",\"zzjgdm\": \" 统一社会信用代码\"},\"material\": [{\"id\":\"材料ID\",\"name\": \"材料名称\"},{\"id\":\"材料ID2\",\"name\": \"材料名称2\"}],\"formdata\":{\"selfmadeformdata\":{\"qymc\": \"华宇\",\"dz\": \"地址\",\"zs\": \"住所\",\"scdz\": [{\"id\": \"01\",\"name\": \"北京市\"},{\"id\": \"02\",\"name\": \"武汉市\"}],\"cp\": [{\"id\": \"1010\",\"name\": \"粮食加工品\"},{\"id\": \"1002\",\"name\": \"肉制品\"}]}}}";
    	//Map<String, Object> obj = (Map<String, Object>) getJsonObject(postdata, live);
    	List<Map<String,Object>> obj = (List<Map<String, Object>>) getJsonObject(postdata, live);
    	//String obj = (String) getJsonObject(postdata, live);
    	System.out.println(obj);
    }
}
