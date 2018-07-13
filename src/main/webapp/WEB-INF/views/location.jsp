<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page session="false"%>
<html>
<head>
<title>AIR Tracker</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!--   <link rel="stylesheet" href="../../resources/theme.min.css">
 -->
<style type="text/css">
body {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-size: 14px;
	line-height: 1.42857143;
	color: #c8c8c8;
	background-color: #272b30;
}
</style>


<!-- Latest compiled and minified JavaScript -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

</head>
<body>
	<div class="container">
		<div class="row">
			<h1>
				GOH Tracker, <small> <i>By Bangalore Randonneurs</i>
				</small>
			</h1>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<div id="googleMap" style="width: 100%; height: 400px;"></div>
			</div>
		</div>

		<br />
		<div class="row">
			<div class="col-lg-12">
				<button class="btn btn-info" data-toggle="tooltip" onclick="getLatestLoction()" id="trackAll">Track All</button>
				<table class="table table-inverse datatable" id="demotable">
					<thead>
						<tr>
							<th>Sr.No</th>
							<th>Athelete</th>
							<th>Bib No</th>
							<th>Last Updated</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${users}" var="currentLoc" varStatus="loop">
							<tr>
								<th scope="row">${loop.index+1}</th>
								<td>${currentLoc.riderName}</td>
								<td>${currentLoc.bibNo}</td>
								<td>
									<p>${currentLoc.displayDate}</p>
								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>


			</div>

		</div>
	</div>





	<script>
		$(document).ready(function () {
		
		
		
		
	});
		function bindInfoWindow(marker, map, infowindow, html, Ltitle) {
			google.maps.event.addListener(marker, 'mouseover', function() {
				infowindow.setContent(html);
				infowindow.open(map, marker);

			});
			google.maps.event.addListener(marker, 'mouseout', function() {
				infowindow.close();

			});
		}

		function myMap() {

			var userLocations = [];

			<c:forEach items="${users}" var="currentLoc" varStatus="loop">
			if("${currentLoc}"!="undefined" && ${currentLoc.lat}!=null){
				var lat = "${currentLoc.lat}";
				var longitude = "${currentLoc.longitude}";
				var bibNo = "${currentLoc.bibNo}";
				var lastUpdated = "${currentLoc.lastUpdated}";
				var riderName = "${currentLoc.riderName}";
				var displayDate = "${currentLoc.displayDate}";
				var loc = {};
				loc.lat = lat;
				loc.lg = longitude;
				loc.bibNo = bibNo;
				loc.lastUpdated = lastUpdated;
				loc.riderName = riderName;
				loc.displayDate = displayDate;
				userLocations.push(loc);
				console.log(userLocations);
			}
			</c:forEach>

			// init map 
			if (userLocations != "undefined" && userLocations.length > 0) {
				var myCenter = new google.maps.LatLng(userLocations[0].lat,
						userLocations[0].lg);
					
			}else{
				var myCenter = new google.maps.LatLng(0,
						0);
				
			}
			/* var myCenter = new google.maps.LatLng(0,
					0); */
			//var map = new google.maps.Map(mapCanvas, mapOptions);
			var map = new google.maps.Map(document.getElementById('googleMap'),
					{
						zoom : 15,
						center : myCenter,
						mapTypeId : google.maps.MapTypeId.ROADMAP
					});
			var infowindow = new google.maps.InfoWindow({
				content : ''
			});

			var markers = [];
			if (userLocations != "undefined" && userLocations.length > 0) {
				for (var i = 0; i < userLocations.length; i++) {
					var location = userLocations[i];
					var latLng = new google.maps.LatLng(location.lat,
							location.lg);
					var marker = new google.maps.Marker({
						position : latLng,
						map : map
					});

					bindInfoWindow(marker, map, infowindow, "<p style='color:black'>" + "Rider Name : "
							+ location.riderName + "("+ location.bibNo +")<br/> crossed this location at : "
							+ location.displayDate+"</p>");

				}

			}
			//poly lines
		  
			var ridePathCordinates =[];
			var cpMarkers = [];

			$.getJSON( "https://audaxtracker.herokuapp.com/resources/route.json", function( data ) {
				  var items = [];
				  $.each( data, function( key, val ) {
				  items.push(val);
				});
			  var track_points = items[0];
			  var control_points = items[1];

			  console.log(track_points[0]);

	  
			  var arrayLength = track_points.length;
			  for (var i = 0; i < arrayLength; i++) {
				  var latlg ={};

				  latlg.lat=track_points[i].y;
				  latlg.lng=track_points[i].x;
				  ridePathCordinates.push(latlg);
			      
			  }
			  console.log(ridePathCordinates);
			  

			  console.log("Size " +ridePathCordinates.length);
			
			 var flightPath = new google.maps.Polyline({
			      path: ridePathCordinates,
			      geodesic: true,
			      strokeColor: '#FF0000',
			      strokeOpacity: 1.0,
			      strokeWeight: 2
			    });
				 flightPath.setMap(map);
				});
			
		}// myMap
		function getSelectedRiderLoction(userId) {
			console.log(userId);
			$.ajax({
				url : 'https://audaxtracker.herokuapp.com/location/trackRider/',
				data : {
					"userId" : userId
				},
				type : 'GET',
				success : function(locatinObj) {
					console.log(locatinObj);
					try {
						var tempObj = locatinObj
						if (tempObj.match("^<!DOCTYPE")) {
						//	location.reload();
						}
						$("#googleMap").empty();

						// init map 
						var myCenter = new google.maps.LatLng(tempObj.lat,
								tempObj.lg);
						//var map = new google.maps.Map(mapCanvas, mapOptions);
						console.log(tempObj.lat);
						var map = new google.maps.Map(document
								.getElementById('googleMap'), {
							zoom : 15,
							center : myCenter,
							mapTypeId : google.maps.MapTypeId.ROADMAP
						});
						var infowindow = new google.maps.InfoWindow({
							content : ''
						});

						var markers = [];

						var latLng = new google.maps.LatLng(tempObj.lat,
								tempObj.lg);
						var marker = new google.maps.Marker({
							position : latLng,
							map : map
						});

						bindInfoWindow(marker, map, infowindow, "<p style='color:black'>" + "Rider Name : "
								+ location.riderName + "("+ location.bibNo +")<br/> crossed this location at : "
								+ location.displayDate+"</p>");

						$("#googleMap").load();
						location.reload();
					} catch (err) {
						//location.reload();
					}
				},
				error : function(e) {
					// location.reload();
				}
			});
		}
		
		function getLatestLoction() {
			$("#trackAll").attr("disabled",true);
			$.ajax({
				url : 'https://audaxtracker.herokuapp.com/location/locationList',
				type : 'GET',
				success : function(locationList) {
					console.log('all locations: ',locationList);
					var myCenter = new google.maps.LatLng(locationList[0].lat,
							locationList[0].longitude);
					var map = new google.maps.Map(document.getElementById('googleMap'),
							{
								zoom : 15,
								center : myCenter,
								mapTypeId : google.maps.MapTypeId.ROADMAP
							});
					var infowindow = new google.maps.InfoWindow({
						content : ''
					});

					var markers = [];
					var markup = "";
					for (var i = 0; i < locationList.length; i++) {
						var location = locationList[i];
						var latLng = new google.maps.LatLng(location.lat,
								location.longitude);
						var marker = new google.maps.Marker({
							position : latLng,
							map : map
						});

						bindInfoWindow(marker, map, infowindow, "<p style='color:black'>" + "Rider Name : "
								+ location.riderName + "("+ location.bibNo +")<br/> crossed this location at : "
								+ location.displayDate+"</p>");
						
						markup += "<tr>"
									+"<th scope='row'>"+(i+1)+"</th>"
									+"<td>"+location.riderName+"</td>"
									+"<td>"+location.bibNo+"</td>"
									+"<td><p>"+location.displayDate+"</p></td>"
									+"</tr>";
					}
					$("table tbody").html(markup);
					$("#trackAll").attr("disabled",false);
					
				}, 
				error : function(e) {
					console.log(e);
				}
			});
		}
		
		
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwBEhySN5YwkbKcLTsCmN8nZm1_odHzoc&callback=myMap"></script>
</body>
</html>
