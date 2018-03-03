import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';



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
        print(path);

        var arg = '';
        if (path.length > 1) {
          arg = path[1];
        }

        print(arg);

        switch (path[0]) {
          case '':
            return new MaterialPageRoute(
              builder: (_) => new MyHomePage(title: 'Flutter'),
              settings: settings
            );
          case 'mash':
            return new MaterialPageRoute(
                builder: (_) => new MediaCapture(),
              settings: settings
            );
          case 'map':
            return new MaterialPageRoute(
                builder: (_) => new MapPage(),
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





class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/mash'),
                child: new Text('Open mash')
            ),
            new FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/map'),
                child: new Text('Open map')
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => { },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
