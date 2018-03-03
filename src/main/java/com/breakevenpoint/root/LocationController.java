package com.breakevenpoint.root;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.breakevenpoint.root.models.Location;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("location")
public class LocationController implements ApplicationContextAware {

	private static final Logger logger = LoggerFactory.getLogger(LocationController.class);
	ApplicationContext context = null;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/track", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Resource resource = this.context.getResource("classpath:locationdb.txt");
		/*try {
			InputStream dbAsStream = resource.getInputStream(); // <-- this is the difference
			String data = readFromInputStream(dbAsStream);

			logger.info("File Contents" + data);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		//
		
		model.addAttribute("currentLoc", mockLocation());
		

		return "location";
	}

	@Override
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		this.context = ctx;
	}

	private String readFromInputStream(InputStream inputStream) throws IOException {
		StringBuilder resultStringBuilder = new StringBuilder();
		try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream))) {
			String line;
			while ((line = br.readLine()) != null) {
				resultStringBuilder.append(line).append("\n");
			}
		}
		return resultStringBuilder.toString();
	}

	private boolean writeToInputStream(String data, String fileName) throws IOException {
		StringBuilder resultStringBuilder = new StringBuilder();

		Resource resource = this.context.getResource("classpath:" + fileName);
		InputStream dbAsStream = resource.getInputStream(); // <-- this is the difference
		BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
		writer.write(data);
		writer.close();

		return true;
	}

	private Location mockLocation() {
		Location mock = new Location();
		mock.setBibNo("RQ-069");
		mock.setLat(19.700792);
		mock.setLongitude(72.751994);
		mock.setRiderName("Neeraj, Palghar");
		mock.setLastUpdated(new Date());
		return mock;
	}

}
