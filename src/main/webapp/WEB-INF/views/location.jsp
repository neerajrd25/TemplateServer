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
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
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

<br/>
		<div class="row">
			<div class="col-lg-8">
				<!-- <ul class="nav nav-pills">
					<li class="active"><a href="#">Solo</a></li>
					<li><a href="#">Team-2</a></li>
					<li><a href="#">Team-3</a></li>
					<li><a href="#">Team-4</a></li>
				</ul> -->

				<table class="table table-hover table-inverse">
					<thead>
						<tr>
							<th>Sr.No</th>
							<th>Athelete</th>
							<th>Bib No</th>
							<th>Last Updated</th>
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
										<fmt:formatDate type="both" value="${currentLoc.lastUpdated}" />
									</p>
								</td>
<%-- 								<td><button class="btn btn-info" data-toggle="tooltip" title="Locate ${currentLoc.userId}">Locate</button></td>
 --%>
							</tr>
						</c:forEach>

						<%-- <tr>
							<th scope="row">4</th>
							<td>Kabir, Mumbai</td>
							<td>RQ-62</td>
							<td><fmt:formatDate type="both"
									value="${currentLoc.lastUpdated}" /></td>
							<td><button class="btn btn-info">Locate</button></td>

						</tr>
						<tr>
							<th scope="row">5</th>
							<td>Neeraj, Pune</td>
							<td>RQ-069</td>
							<td><fmt:formatDate type="both"
									value="${currentLoc.lastUpdated}" /></td>
							<td><button class="btn btn-info">Locate</button></td>
						</tr> --%>
					</tbody>
				</table>


			</div>
			<%-- <div class="col-lg-4">
				<form class="navbar-form" role="search">
					<div class="input-group">
						<input type="text" class="form-control"
							placeholder="Search for..."> <span
							class="input-group-btn">
							<button class="btn btn-default" type="button">Go!</button>
						</span>
					</div>
					<!-- /input-group -->
				</form>
				<table class="table table-hover table-inverse">
					<tr class="bg-primary">
						<td><input type="checkbox" val="all" /></td>
						<td>All</td>
					</tr>
					<c:forEach items="${users}" var="currentLoc">
						<tr>
							<td><input type="checkbox" val="${currentLoc.userId}"
								checked="checked" /></td>
							<td>${currentLoc.riderName}</td>
						</tr>
					</c:forEach>
					<tr>
						<td><input type="checkbox" val="neeraj" /></td>
						<td>Amit</td>
					</tr>
					<tr>
						<td><input type="checkbox" val="neeraj" /></td>
						<td>Srinivas</td>
					</tr>
					<tr>
						<td><input type="checkbox" val="neeraj" /></td>
						<td>Amey</td>
					</tr>

				</table>



			</div> --%>
		</div>
	</div>





	<script>
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

			</c:forEach>

			// init map 
			var myCenter = new google.maps.LatLng(userLocations[1].lat,
					userLocations[1].lg);
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

			for (var i = 0; i < 3; i++) {
				var location = userLocations[i];
				var latLng = new google.maps.LatLng(location.lat, location.lg);
				var marker = new google.maps.Marker({
					position : latLng,
					map : map
				});

				bindInfoWindow(marker, map, infowindow, "<p>" + "Rider : "
						+ location.bibNo + " : crossed this location at : "
						+ location.lastUpdated);

				/* markers.push(marker);
				var infowindow = new google.maps.InfoWindow({
					content : "Rider : " + location.bibNo + " : crossed this location at : "
							+ location.lastUpdated
				});
				google.maps.event.addListener(marker, 'click', function() {
					infowindow.open(map, marker);
				}); */

			}
			//var markerCluster = new MarkerClusterer(map, markers);

			/* var mapOptions = {
				center : myCenter,
				zoom : 15
			}; */

			/* var marker = new google.maps.Marker({
				position : myCenter
			});
			 */

			//marker.setMap(map);
		}
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwBEhySN5YwkbKcLTsCmN8nZm1_odHzoc&callback=myMap"></script>
</body>
</html>
