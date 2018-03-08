package com.breakevenpoint.root;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.breakevenpoint.root.models.Location;

public class HTTPClientUtil {
	// http://localhost:8080/RESTfulExample/json/product/post
	public static void main(String[] args) {
		final String USER_AGENT = "Mozilla/5.0";

		try {
		
			Location mockObj= mockLocation();
			
			 StringBuilder stringBuilder = new StringBuilder("http://localhost:8080/root/location/submitLocGET?");
		    /* stringBuilder.append("?lat=" );
		     stringBuilder.append(URLEncoder.encode(String.valueOf(mockObj.getLat()), "UTF-8"));
		     stringBuilder.append("?lg=" );
		     stringBuilder.append(URLEncoder.encode(String.valueOf(mockObj.getLongitude()), "UTF-8"));
		     stringBuilder.append("?lastUpdated=" );
		     stringBuilder.append(URLEncoder.encode(String.valueOf(mockObj.getLastUpdated().getTime()), "UTF-8"));*/
			
		     Map<String, Object> parameters = new HashMap<>();
		     parameters.put("lat", mockObj.getLat());
		     parameters.put("lg", mockObj.getLongitude());
		     parameters.put("lastUpdated", mockObj.getLastUpdated().getTime());
		     parameters.put("userId", mockObj.getUserId());

		     stringBuilder.append(getParamsString(parameters));
			
			URL url = new URL(stringBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("User-Agent", USER_AGENT);
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			

			
			//conn.setRequestProperty("lastUpdated", String.valueOf(new Date().getTime()));
			//conn.setRequestProperty("Content-Type", "application/json");
		
			System.out.println(conn.getResponseCode());
			if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
				throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
			}

			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));

			String output;
			System.out.println("Output from Server .... \n");
			while ((output = br.readLine()) != null) {
				System.out.println(output);
			}
			br.close();

			conn.disconnect();

		} catch (MalformedURLException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		}

	}
	
	public static String getParamsString(Map<String, Object> params) 
		      throws UnsupportedEncodingException{
		        StringBuilder result = new StringBuilder();
		 
		        for (Map.Entry<String, Object> entry : params.entrySet()) {
		          result.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
		          result.append("=");
		          result.append(URLEncoder.encode(entry.getValue().toString(), "UTF-8"));
		          result.append("&");
		        }
		 
		        String resultString = result.toString();
		        return resultString.length() > 0
		          ? resultString.substring(0, resultString.length() - 1)
		          : resultString;
		    }
	//18.644689, 73.736866
	//18.560716, 73.768945
	//@18.5656129,73.7628549,16z
	private static Location mockLocation() {
		Location mock = new Location();
		mock.setBibNo("RQ-069");
		
		mock.setUserId("dc_divya");
		mock.setLat(18.644689);
		mock.setLongitude(73.736866);
		

	/*	mock.setUserId("dc_dantus");
		mock.setLat(18.560716);
		mock.setLongitude(73.768945);*/


		/*mock.setUserId("dc_raghu");
		mock.setLat(18.5656129);
		mock.setLongitude(73.7628549);*/

		
		mock.setRiderName("Neeraj, Palghar");
		mock.setLastUpdated(new Date());
		
		return mock;
	}

}
