package action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ModelDriven;

import entity.Emp;
import entity.User;

/**
 *	Struts2的HelloWorld示例。
 *	业务：在控制台输出一句话。
 */
public class HelloAction {
	
	//基本属性
	private int id = 6;
	private String name = "Tarena";
	//实体对象
	private User user = new User();
	//初始化集合/数组
	private List<String> langList = 
		new ArrayList<String>();
	private String[] langArray = 
		new String[] {"Java","php","c#"};
	//初始化Map
	private Map<String, String> empMap = 
		new HashMap<String, String>();
	
	public String sayHello() {
		//初始化实体对象数据
		user.setUserName("Zhangsan");
		user.setPassword("abc");
		//初始化集合数据
		langList.add("Java");
		langList.add("php");
		langList.add("c#");
		//初始化Map数据
		empMap.put("zhangsan", "Java");
		empMap.put("lisi", "php");
		empMap.put("wangwu", "c#");
		
		return "ok";
	}

	public Map<String, String> getEmpMap() {
		return empMap;
	}

	public void setEmpMap(Map<String, String> empMap) {
		this.empMap = empMap;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String[] getLangArray() {
		return langArray;
	}

	public void setLangArray(String[] langArray) {
		this.langArray = langArray;
	}

	public List<String> getLangList() {
		return langList;
	}

	public void setLangList(List<String> langList) {
		this.langList = langList;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * 业务方法：输出"你好,Action"
	 */
	public String sayNihao() {
		System.out.println("你好，Action");
		return "ok";
	}
	
}
