package org.dragonscale.models;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.dragonscale.utils.Const;

/**
 * @Author Aliqi
 * @Date 2016年6月12日
 **/
public class Supplier implements Serializable {

	private static final long serialVersionUID = -6975089615348457433L;
	private String id;
	private String name;
	private String description;
	private String password;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Supplier() {
	}

	public Supplier(String name, String password, String description) {
		this.name = name;
		this.password = password;
		this.description = description;
	}

	@Override
	public String toString() {
		return "Name: " + name;
	}

	public void updateSession(HttpSession session) {
		session.setAttribute(Const.supplier, this);
	}

	public static Supplier fromSession(HttpSession session) {
		Object obj = session.getAttribute(Const.supplier);
		if (obj instanceof Supplier)
			return (Supplier) obj;
		return null;
	}

	public static Supplier fromRequest(HttpServletRequest req) {
		return fromSession(req.getSession());
	}
}
