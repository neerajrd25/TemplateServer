package com.breakevenpoint.root;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breakevenpoint.root.models.Location;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("location")
public class LocationController implements ApplicationContextAware {

	private static final Logger logger = LoggerFactory.getLogger(LocationController.class);
	ApplicationContext context = null;

	private static Map<String, Location> userLocations = new HashMap<>();

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/track", method = RequestMethod.GET)
	public String liveTrack(Locale locale, Model model) {
		//model.addAttribute("currentLoc", CURRENT_LOCATION);
		model.addAttribute("users", new ArrayList<Location>(userLocations.values()));

		return "location";
	}
	@ResponseBody
	@RequestMapping(value = "/locationList", method = RequestMethod.GET)
	public List<Location> getLocations(Locale locale, Model model) {
		//model.addAttribute("currentLoc", CURRENT_LOCATION);
		

		return new ArrayList<Location>(userLocations.values());
	}


	

	
	@ResponseBody
	@RequestMapping(value = { "/submitLocGET" }, method = RequestMethod.GET)
	public String submitLocationGet(HttpServletRequest request, Model model) {
		String lat = request.getParameter("lat");
		String lg = request.getParameter("lg");
		String lastUpdated = request.getParameter("lastUpdated");
		String deviceId = request.getParameter("userId");
		String riderName = request.getParameter("riderName");
		String bibNo = request.getParameter("bibNo");

		Date d = new Date(Long.parseLong(lastUpdated));
		
		
		logger.info("Tracking service lt " + lat);
		logger.info("Longitude :" + lg);
		logger.info("lastUpdated:" + d);
		logger.info("Tracking service device id:" + deviceId);
		logger.info("Tracking service riderName:" + riderName);
		logger.info("Tracking service bibNO:" + bibNo);

		Location l = null;

		l = userLocations.get(deviceId);

		if (l != null) {
			l.setLat(Double.valueOf(lat));
			l.setLongitude(Double.valueOf(lg));
			l.setLastUpdated(d);
			l.setRiderName(riderName);
			l.setBibNo(bibNo);
			l.setDisplayDate(lastUpdated);
			userLocations.put(deviceId, l);
		} else {
			l = new Location(riderName, bibNo, deviceId);
			l.setLat(Double.valueOf(lat));
			l.setLongitude(Double.valueOf(lg));
			l.setLastUpdated(d);
			l.setDisplayDate(lastUpdated);
			userLocations.put(deviceId, l);
		}
		
		logger.info("Tracking service Obj " + l);
		return "SUCCESS";

	}

	

	@RequestMapping(value = { "/trackRider" }, method = RequestMethod.GET,produces = "application/json; charset=utf-8")
	@ResponseBody
	private String trackRider(@RequestParam(value="userId")String userId) {
		Location l = null;
		 String jsonStr="";
		try {
			// l = call to database service  
			
			Random num =new Random();
			l = userLocations.get(userId);
			l.setLat(1+num.nextInt(100));
			l.setLongitude(1+num.nextInt(100));
			l.setLastUpdated(new Date());
	
			ObjectMapper mapperObj = new ObjectMapper();
	         
	  
	             jsonStr = mapperObj.writeValueAsString(l);
	            System.out.println(jsonStr);			
			
		} catch (Exception e) {
			LoggerFactory.getLogger(getClass()).error(e.getMessage());
		}
		return jsonStr;
	}
	
	@Override
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		this.context = ctx;
	}

	private Location mockLocation() {
		Location mock = new Location();
		mock.setBibNo("RQ-069");
		mock.setLat(19.700792);
		mock.setLongitude(72.751994);
		mock.setRiderName("Neeraj, Palghar");
		mock.setLastUpdated(new Date());
		mock.setUserId("admin");
		return mock;
	}

}
