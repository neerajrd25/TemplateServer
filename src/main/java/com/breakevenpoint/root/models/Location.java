package com.breakevenpoint.root.models;

import java.util.Date;

public class Location {

	@Override
	public String toString() {
		return "Location [riderName=" + riderName + ", lat=" + lat + ", longitude=" + longitude + ", bibNo=" + bibNo
				+ ", lastUpdated=" + lastUpdated + ", userId=" + userId + "]";
	}

	String riderName;
	double lat;
	double longitude;
	String bibNo;
	Date lastUpdated = new Date();
	String userId;
	

	public Location() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getUserId() {
		return userId;
	}

	public Location(String riderName, String bibNo, String userId) {
		super();
		this.riderName = riderName;
		this.bibNo = bibNo;
		this.userId = userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRiderName() {
		return riderName;
	}

	public void setRiderName(String riderName) {
		this.riderName = riderName;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getBibNo() {
		return bibNo;
	}

	public void setBibNo(String bibNo) {
		this.bibNo = bibNo;
	}

	public Date getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

}
