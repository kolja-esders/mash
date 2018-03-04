import 'package:flutter/material.dart';

import 'mash_page.dart';
import 'profile_page.dart';

void main() => runApp(new MyApp());

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
                builder: (_) => new MashPage(),
              settings: settings
            );
          case 'profile':
            return new MaterialPageRoute(
                builder: (_) => new ProfilePage(
                    name: 'Sarah Engels',
                    avatar: ''
                ),
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
                onPressed: () => Navigator.pushNamed(context, '/profile'),
                child: new Text('Open profile')
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
