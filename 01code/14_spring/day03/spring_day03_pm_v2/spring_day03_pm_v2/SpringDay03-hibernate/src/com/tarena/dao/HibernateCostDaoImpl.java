package com.tarena.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.tarena.entity.Cost;

public class HibernateCostDaoImpl 
	extends HibernateDaoSupport 
	implements ICostDao {

	public void delete(int id) {
		Cost c = new Cost();
		c.setId(id);
		getHibernateTemplate().delete(c);
	}

	public List<Cost> findAll() {
		String hql = "from Cost";
		return getHibernateTemplate().find(hql);
	}

	public Cost findById(int id) {
		return (Cost) getHibernateTemplate()
			.get(Cost.class, id);
	}

	public void save(Cost cost) {
		cost.setStatus("0");
		cost.setCreatTime(
			new Date(System.currentTimeMillis()));
		getHibernateTemplate().save(cost);
	}

	public void update(Cost cost) {
		getHibernateTemplate().update(cost);
	}

}
