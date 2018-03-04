import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'profile_page.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';

import 'mash_page.dart';
import 'media_capture.dart';
import 'map.dart';


var API_KEY = "AIzaSyD0bmHFAcM9cVUZiEPvkjgX0nzc78lKVNA";

void main() {
  MapView.setApiKey(API_KEY);
  runApp(new MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: new MyHomePage(title: 'Flutter'),
        onGenerateRoute: (RouteSettings settings) {
          var path = settings.name.substring(1).split('/');

          var arg = '';
          if (path.length > 1) {
            arg = path[1];
          }

          switch (path[0]) {
            case '':
              return new MaterialPageRoute(
                  builder: (_) => new MyHomePage(title: 'Flutter'),
                  settings: settings
              );
            case 'mash':
              return new MaterialPageRoute(
                  builder: (_) => new MashPage(),
                  settings: settings
              );
            case 'profile':
              return new MaterialPageRoute(
                  builder: (_) =>
                  new ProfilePage(
                      name: 'Sarah Engels',
                      avatar: ''
                  ),
                  settings: settings
              );
            case 'map':
              return new MaterialPageRoute(
                builder: (_) =>
                  new MapPage(),
              settings: settings
            );

          }

        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  final _images = [
    "images/hockey.jpg",
    "images/rings.jpg",
    "images/ski.jpg",
    "images/cheer.jpg"
  ];


  List<FabMiniMenuItem> _fabMiniMenuItemList = [
    new FabMiniMenuItem(
      onPressed: () {},
      textColor: Colors.white,
      chipColor: Colors.deepOrange,
      fabColor: Colors.deepOrange,
      icon: new Icon(Icons.movie),
      elevation: 4.0,
      text: "Create a Mash",
      tooltip: "Button menu",
    ),
    new FabMiniMenuItem(
      onPressed: () {},
      textColor: Colors.white,
      chipColor: Colors.deepOrange,
      fabColor: Colors.deepOrange,
      icon: new Icon(Icons.insert_photo),
      elevation: 4.0,
      text: "Upload a Clip",
      tooltip: "Button menu",
    ),
    new FabMiniMenuItem(
      onPressed: () {},
      textColor: Colors.white,
      chipColor: Colors.deepOrange,
      fabColor: Colors.deepOrange,
      icon: new Icon(Icons.camera_alt),
      elevation: 4.0,
      text: "Take a Clip",
      tooltip: "Button menu",
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton( // action button
            icon: new Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          new IconButton( // action button
            icon: new Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/map'),
          ),
          new IconButton( // action button
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      body: new ListView(
        children: <Widget>[
          new Column(
            children: _buildImgeList(),
          ),
        ],

      ),
      //floatingActionButton: new FabDialer(
      //    _fabMiniMenuItemList, Colors.deepOrange, new Icon(Icons.add)),
    );
  }


  List<Widget> _buildImgeList() {
    var wList = [];

    for (int i = 0; i < _images.length; i++) {
      // wList.add( new Image.asset(_images[i]));
      wList.add(
          new Stack(
            children: <Widget>[
              new AspectRatio(
                  aspectRatio: 20 / 9,
                  child: new Stack(
                    children: <Widget>[
                      new Container(
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.fitWidth,
                              alignment: FractionalOffset.topCenter,
                              image: new AssetImage(_images[i]),
                            )
                        ),
                      ),
                      new Positioned(
                        child: new Container(
                          decoration: new BoxDecoration(
                            gradient: new RadialGradient(
                              radius: 1.5,
                              colors: <Color>[
                                Colors.transparent,
                                const Color.fromARGB(200, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      new Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child:
                        new Material(
                            color: Colors.transparent,
                            child: new Container(
                              height: 72.0,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new IconButton(
                                    onPressed: () => {},
                                    icon: new Icon(Icons.play_circle_outline),
                                    color: Colors.white,
                                    splashColor: Colors.redAccent,
                                    iconSize: 48.0,
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      new Text(
                                        "watch",
                                        style: new TextStyle(
                                            color: Colors.white30,
                                            decoration: TextDecoration.underline
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      new Text(
                                        "Olympics - Day 1",
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  )
              ),
              new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/mash');
                  },
                  child: new AspectRatio(
                      aspectRatio: 20 / 9,
                      child: new Material(
                        color: Colors.transparent,
                      )
                  )
              ),

            ],
          )
      );
    }

    return wList;
  }

}
