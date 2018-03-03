<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page session="false"%>
<html>
<head>
<title>Home</title>

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
				Deccan Cliffhanger 2018, <small> <i>By Inspire India</i>
				</small>
			</h1>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<div id="googleMap" style="width: 100%; height: 400px;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-8">
				<ul class="nav nav-pills">
					<li class="active"><a href="#">Solo</a></li>
					<li><a href="#">Team-2</a></li>
					<li><a href="#">Team-3</a></li>
					<li><a href="#">Team-4</a></li>
				</ul>

				<table class="table table-hover table-inverse">
					<thead>
						<tr>
							<th>Position</th>
							<th>Athelete</th>
							<th>Bib No</th>
							<th>Last Updated</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td>${currentLoc.riderName}</td>
							<td>${currentLoc.bibNo}</td>
							<td>
								<p>
									<fmt:formatDate type="both" value="${currentLoc.lastUpdated}" />
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row">2</th>
							<td>Kabir, Mumbai</td>
							<td>RQ-62</td>
							<td><fmt:formatDate type="both"
									value="${currentLoc.lastUpdated}" /></td>
						</tr>
						<tr>
							<th scope="row">3</th>
							<td>Divya, Pune</td>
							<td>RQ-01</td>
							<td><fmt:formatDate type="both"
									value="${currentLoc.lastUpdated}" /></td>
						</tr>
					</tbody>
				</table>


			</div>
			<div class="col-lg-4">
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

					<tr>
						<td><input type="checkbox" val="neeraj" checked="checked" /></td>
						<td>${currentLoc.riderName}</td>
					</tr>
					<tr>
						<td><input type="checkbox" val="neeraj" checked="checked" /></td>
						<td>Divya</td>
					</tr>
					<tr>
						<td><input type="checkbox" val="neeraj" checked="checked" /></td>
						<td>Kabir</td>
					</tr>
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
						<td>Advait</td>
					</tr>

				</table>



			</div>
		</div>
	</div>






	Location ${currentLoc}
	<script>
		function myMap() {
			var lat = "${currentLoc.lat}";
			var longitude = "${currentLoc.longitude}";
			var bibNo = "${currentLoc.bibNo}";
			var lastUpdated = "${currentLoc.lastUpdated}";

			var myCenter = new google.maps.LatLng(lat, longitude);
			var mapCanvas = document.getElementById("googleMap");
			var mapOptions = {
				center : myCenter,
				zoom : 15
			};
			var map = new google.maps.Map(mapCanvas, mapOptions);
			var marker = new google.maps.Marker({
				position : myCenter
			});

			var infowindow = new google.maps.InfoWindow({
				content : "Rider : " + bibNo + " : crossed this location at : "
						+ lastUpdated
			});
			google.maps.event.addListener(marker, 'click', function() {
				infowindow.open(map, marker);
			});

			marker.setMap(map);
		}
	</script>

	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwBEhySN5YwkbKcLTsCmN8nZm1_odHzoc&callback=myMap"></script>
</body>
</html>
