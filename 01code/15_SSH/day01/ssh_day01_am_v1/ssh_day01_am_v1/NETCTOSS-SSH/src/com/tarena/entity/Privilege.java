package com.tarena.entity;

import java.util.List;

/**
 *	ģ��ʵ����
 */
public class Privilege {

	private Integer id;
	private String name;
	private List<String> urls;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String> getUrls() {
		return urls;
	}

	public void setUrls(List<String> urls) {
		this.urls = urls;
	}

}
