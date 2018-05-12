package com.breakevenpoint.root;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breakevenpoint.root.models.Location;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("location")
public class LocationController implements ApplicationContextAware {

	private static final Logger logger = LoggerFactory.getLogger(LocationController.class);
	ApplicationContext context = null;

	private Location CURRENT_LOCATION = mockLocation();

	private static Map<String, Location> userLocations = new HashMap<>();

	static {
		Location l;
		l = new Location("Divya Tate", "RQ-001", "dc_divya");
		userLocations.put(l.getUserId(), l);
		l = new Location("Dantus", "RQ-002", "dc_dantus");
		userLocations.put(l.getUserId(), l);
		l = new Location("Raghu", "RQ-003", "dc_raghu");
		userLocations.put(l.getUserId(), l);
	}

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/track", method = RequestMethod.GET)
	public String liveTrack(Locale locale, Model model) {
		model.addAttribute("currentLoc", CURRENT_LOCATION);
		model.addAttribute("users", new ArrayList<Location>(userLocations.values()));

		return "location";
	}

	@RequestMapping(value = "/demoTrack", method = RequestMethod.GET)
	public String demoTrack(Locale locale, Model model) {
		model.addAttribute("currentLoc", mockLocation());

		return "location";
	}

	@ResponseBody
	@RequestMapping(value = { "/submitLoc" }, method = RequestMethod.POST)
	public String submitLocation(Model model, HttpServletRequest request, Locale locale,
			@RequestBody String locationJSON) {
		logger.info("Service JSON->" + locationJSON);

		// JSONObject jsonObj = new
		// JSONObject("{\"phonetype\":\"N95\",\"cat\":\"WP\"}");
		GsonBuilder gsonBuilder = new GsonBuilder();
		// "Mar 5, 2018 4:28:12 PM
		// gsonBuilder.setDateFormat("MMM MM-dd hh:mm:ss a");
		gsonBuilder.setDateFormat("dd MMM yyyy HH:mm:ss");
		Gson gson = gsonBuilder.create();
		CURRENT_LOCATION = gson.fromJson(locationJSON, Location.class);

		logger.info("Service DATA->" + CURRENT_LOCATION);
		return "SUCCESS";
	}

	@ResponseBody
	@RequestMapping(value = { "/submitLocGET" }, method = RequestMethod.GET)
	public String submitLocationGet(HttpServletRequest request, Model model) throws ParseException {
		String lat = request.getParameter("lat");
		String lg = request.getParameter("lg");
		String lastUpdated = request.getParameter("lastUpdated");
		String userId = request.getParameter("userId");
		String riderName = request.getParameter("riderName");
		String bibNo = request.getParameter("bibNo");

		DateFormat utcFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss 'GMT' yyyy", Locale.US);
	    utcFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
	    DateFormat indianFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss 'GMT' yyyy", Locale.US);
	    utcFormat.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
	    Date timestamp = utcFormat.parse(lastUpdated);

		logger.info("Tracking service lt " + lat);
		logger.info("Tracking service lg :" + lg);
		logger.info("Tracking service lastUpdated:" + timestamp);
		logger.info("Tracking service userId:" + userId);
		Location l = null;
		l = userLocations.get(userId);
		if (l != null) {
			l.setLat(Double.valueOf(lat));
			l.setLongitude(Double.valueOf(lg));
			l.setLastUpdated(timestamp);
			l.setRiderName(riderName);
			l.setBibNo(bibNo);
			
			userLocations.put(userId, l);
		} else {
			l = new Location(riderName, bibNo, userId);
			l.setLat(Double.valueOf(lat));
			l.setLongitude(Double.valueOf(lg));
			userLocations.put(userId, l);

		}

		logger.info("Tracking service Obj " + l);

		return "SUCCESS";
	}

	@ResponseBody
	@RequestMapping(value = { "/demo" }, method = RequestMethod.GET)
	public String addAppointment() {
		logger.info("Tracking service");
		return "SUCCESS";
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
		mock.setUserId("dcadmin");
		return mock;
	}

}
