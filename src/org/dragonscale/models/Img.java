package org.dragonscale.models;

public class Img {
	public String id;
	public String imgurl;
	
	public Img() {

	}	
	
	public Img(String id, String imgurl) {
		super();
		this.id = id;
		this.imgurl = imgurl;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

	@Override
	public String toString() {
		return "Img [id=" + id + ", imgurl=" + imgurl + "]";
	}
}
