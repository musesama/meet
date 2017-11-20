// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()


function initAutocomplete() {
  if (!$("#map").length > 0) {
	return;
  }
  let dd = $($("#map")[0]);
  let r_id = dd.data('room-id');
  let path = dd.data('path');
  let channel = socket.channel("room:"+r_id, {});
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.8688, lng: 151.2195},
    zoom: 13,
    mapTypeId: 'roadmap'
  });
  navigator.geolocation.getCurrentPosition(pos => {
    var d = {lat: pos.coords.latitude, lng: pos.coords.longitude};
    map.setCenter(d);
  });
  function continus_send_pos() {
    function sendpos(pos) {
      channel.push("geoloc", {handler:'a', lat: pos.coords.latitude, lon: pos.coords.longitude})
    }
    navigator.geolocation.getCurrentPosition(sendpos);
    setTimeout(continus_send_pos, 5000);
  }
  continus_send_pos();
  var geolocs = {}
  channel.on("geoloc", v => {
    var m = geolocs[v['handler']]
    if (m != undefined) {
      m.setMap(null);
    }
    geolocs[v['handler']] = new google.maps.Marker({
      position: {lat: v['lat'], lng: v['lon']},
      map: map,
      title: v['handler']
    })
  })

  // Create the search box and link it to the UI element.
  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });


  var remote_markers = [];
  function fetch_markers() {
    function got_markers(data) {
      console.log(data)
      data = data['data']
      remote_markers.forEach(function(marker) {
	marker.setMap(null);
      });
      remote_markers = [];
      data.forEach(function(v) {
	remote_markers.push(new google.maps.Marker({
	  position: {lat: v['lat'], lng: v['lon']},
	  map: map,
	  title: 'Hello World!'
      }))});
    }

    $.ajax({
      url: path,
      data: {room_id: r_id},
      contentType: "application/json",
      dataType: "JSON",
      method: "GET",
      success: got_markers,
    });
  }
  fetch_markers()
  function add_marker(e) {
    let data = {marker: {room_id: r_id, lon: e.latLng.lng(), lat: e.latLng.lat()}};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_markers,
    });
  }
  map.addListener('click', add_marker);
    
  var markers = [];
  var myLatLng = {lat: -33.8688, lng: 151.2195};
  var customMarker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    title: 'Hello World!'
  });
  customMarker.addListener('click', function() {
    alert('clicked');
  });
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener('places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }

    // Clear out the old markers.
    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    markers = [];

    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      if (!place.geometry) {
	console.log("Returned place contains no geometry");
	return;
      }
      var icon = {
	url: place.icon,
	size: new google.maps.Size(71, 71),
	origin: new google.maps.Point(0, 0),
	anchor: new google.maps.Point(17, 34),
	scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      markers.push(new google.maps.Marker({
	map: map,
	icon: icon,
	title: place.name,
	position: place.geometry.location
      }));

      if (place.geometry.viewport) {
	// Only geocodes have viewport.
	bounds.union(place.geometry.viewport);
      } else {
	bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
}

export {initAutocomplete}
export default socket
