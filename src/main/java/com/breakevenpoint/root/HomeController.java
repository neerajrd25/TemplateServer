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

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController implements ApplicationContextAware {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	ApplicationContext context = null;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		Resource resource = this.context.getResource("classpath:locationdb.txt");
		try {
			InputStream dbAsStream = resource.getInputStream(); // <-- this is the difference
			String data = readFromInputStream(dbAsStream);

			logger.info("File Contents" + data);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//
		logger.info("Writing to file");
		try {
			writeToInputStream("New data", resource.getFilename());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "home";
	}

	@Override
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		this.context = ctx;
	}

	private String readFromInputStream(InputStream inputStream) throws IOException {
		StringBuilder resultStringBuilder = new StringBuilder();
		try {
			String line;
			BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
			while ((line = br.readLine()) != null) {
				resultStringBuilder.append(line).append("\n");
			}
		} catch (Exception ex) {

		} finally {
			
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

}
