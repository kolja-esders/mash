import 'package:flutter/material.dart';

import 'package:map_view/map_view.dart';

var API_KEY = "AIzaSyD0bmHFAcM9cVUZiEPvkjgX0nzc78lKVNA";


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapView mapView = new MapView();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri staticMapUri;


  @override
  initState() {
    super.initState();
    staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
        width: 900, height: 400);
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Map'),
        ),
        body: new Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: 250.0,

                child: new Stack(
                children: <Widget>[


                  new InkWell(
                    child: new Center(
                      child: new Image.network(staticMapUri.toString()),
                    ),
                    onTap: showMap,
                  )
                ],
              ),
            ),

          ],
        ));



  }

  showMap(){
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: new CameraPosition(
                new Location(26.315083, -80.24724), 14.0),
            title: "Florida school shooting"),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    mapView.setMarkers(<Marker>[
      new Marker("1", "Work", 26.315083, -80.24724, color: Colors.blue),
      new Marker("2", "Nossa Familia Coffee", 26.315083, -80.24724),
    ]);
  }


}