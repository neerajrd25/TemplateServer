package com.breakevenpoint.root.models;

import java.util.Date;

public class Location {

	@Override
	public String toString() {
		return "Location [riderName=" + riderName + ", lat=" + lat + ", longitude=" + longitude + ", bibNo=" + bibNo
				+ ", lastUpdated=" + lastUpdated + "]";
	}

	String riderName;
	double lat;
	double longitude;
	String bibNo;
	Date lastUpdated;

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
