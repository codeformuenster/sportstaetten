map = L.mapbox.map('map', 'codeformuenster.ino9j865')

$.getJSON '../data/sportstaetten.geojson', (json)->
  #$scope.markers = $scope.getMarkers(geojson)
  #$scope.map.fitBounds $scope.markers.getBounds()
  #$scope.map.addLayer $scope.markers

  markers = new L.MarkerClusterGroup()

  for feature in json.features
    coords = feature.geometry.coordinates
    marker = L.marker(new L.LatLng(coords[1], coords[0]))

    markerIcon = icon:
      iconUrl: "images/#{feature.properties.Teilprodukt.toLowerCase()}.png"
      iconAnchor: [25, 25]
      popupAnchor: [0, -25]
      className: "dot"
    marker.setIcon(L.icon(markerIcon.icon))

    teilprodukt = "<h3 style='margin-bottom:0px;'>#{feature.properties.Teilprodukt}</h3>"
    object = "<p>#{feature.properties.Objekt}</p>"
    address = "<p><b>Anschrift</b></br>"
    address = "#{address}#{feature.properties.Strname} #{feature.properties.Hsnr}</br>"
    address = "#{address}#{feature.properties.Plz} Münster</p>"

    panelHead = teilprodukt
    panelBody = "#{object}<table class='table table-striped'>#{address}</table>"
    panel = panelHead + panelBody

    marker.bindPopup panel, closeButton: false
    markers.addLayer marker

    markers.on 'mouseover', (e) ->
      e.layer.openPopup()
    markers.on 'mouseout', (e) ->
      e.layer.closePopup()

  map.fitBounds markers.getBounds()
  map.addLayer markers
 
