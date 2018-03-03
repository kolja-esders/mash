import 'package:flutter/material.dart';
import 'dart:async';
import 'package:map_view/map_view.dart';
import 'media_capture.dart';

var API_KEY = "AIzaSyD0bmHFAcM9cVUZiEPvkjgX0nzc78lKVNA";


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapView mapView = new MapView();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri staticMapUri;
  CameraPosition cameraPosition;
  var compositeSubscription = new CompositeSubscription();


  @override
  initState() {
    super.initState();
    cameraPosition = new CameraPosition(Locations.portland, 12.0);
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
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new ListView(
                            padding: new EdgeInsets.all(16.0),
                            children: <Widget>[
                              new MediaCapture(
                                  key: new Key('x'),
                                  avatar: 'x',
                                  author: 'Klaus Kleber',
                                  likes: 10,
                                  link: 'tba'
                              ),
                            ]

                        ),

                      ),
                    ]

                  ),

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
                new Location(45.523970, -122.663081), 14.0),
            title: "Florida school shooting"),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    var sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(<Marker>[
        new Marker("1", "p1", 45.523970, -122.663081, color: Colors.blue),
        new Marker("2", "p2", 45.528788, -122.684633),
      ]);
      mapView.addMarker(new Marker("3", "p3", 45.5259467, -122.687747,
          color: Colors.purple));

      mapView.zoomToFit(padding: 100);
    });
    compositeSubscription.add(sub);

    sub = mapView.onLocationUpdated
        .listen((location) => print("Location updated $location"));
    compositeSubscription.add(sub);

    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation tapped"));
    compositeSubscription.add(sub);

    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);

    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this.cameraPosition = cameraPosition));
    compositeSubscription.add(sub);

    sub = mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);

    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
  }

  _handleDismiss() async {
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();

  }



}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
