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
				AIR Tracker, <small> <i>By Audax India</i>
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
			<div class="col-lg-8">
				<button class="btn btn-info" data-toggle="tooltip">Track
					All</button>
				<!-- <ul class="nav nav-pills">
					<li class="active"><a href="#">Solo</a></li>
					<li><a href="#">Team-2</a></li>
					<li><a href="#">Team-3</a></li>
					<li><a href="#">Team-4</a></li>
				</ul> -->

				<table class="table table-hover table-inverse datatable" id="demotable">
					<thead>
						<tr>
							<th>Sr.No</th>
							<th>Athelete</th>
							<th>Bib No</th>
							<th>Last Updated</th>
							<th>Track</th>
							
							<!-- 							<th>Locate</th>
 -->
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${users}" var="currentLoc" varStatus="loop">

							<tr>
								<th scope="row">${loop.index+1}</th>
								<td>${currentLoc.riderName}</td>
								<td>${currentLoc.bibNo}</td>
								<td>
									<p>
											<%-- 	<fmt:formatDate type="both" value="${currentLoc.lastUpdated}" /> --%>
									${currentLoc.displayDate}
										</p>
								</td>
								<td>

										<button class="btn btn-info" data-toggle="tooltip" id="${currentLoc.userId}"
											title="Locate ${currentLoc.riderName}"
											onclick="getSelectedRiderLoction('${currentLoc.userId}')">Track</button>
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
			var loc = {};
			loc.lat = lat;
			loc.lg = longitude;
			loc.bibNo = bibNo;
			loc.lastUpdated = lastUpdated;
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
						zoom : 12,
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

					bindInfoWindow(marker, map, infowindow, "<p>" + "Rider : "
							+ location.bibNo + " : crossed this location at : "
							+ location.lastUpdated);

				}

			}
			//poly lines
		  
			var ridePathCordinates =[];
			var cpMarkers = [];

			$.getJSON( "http://localhost:8090/root/resources/route.json", function( data ) {
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
				url : 'http://localhost:8090/root/location/trackRider/',
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
							zoom : 12,
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

						bindInfoWindow(marker, map, infowindow, "<p>"
								+ "Rider : " + tempObj.bibNo
								+ " : crossed this location at : "
								+ tempObj.lastUpdated);

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
		
		
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwBEhySN5YwkbKcLTsCmN8nZm1_odHzoc&callback=myMap"></script>
</body>
</html>
