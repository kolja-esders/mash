import 'package:flutter/material.dart';


import 'mash_page.dart';

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
    "images/cheer.jpg",
    "images/trump.jpeg",
    "images/bieber.jpg",
    "images/ski.jpg"
  ];

  final _titles = [
    "Olympic Winter Games 2018",
    "Trump + Xi = <3 ?",
    "Planed Attack on Justin Bieber",
    "Norway skis it's way to Olympic Crone"
  ];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
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
      floatingActionButton: new FloatingActionButton(
        onPressed: () => { },
        tooltip: 'Increment',
        child: new Icon(Icons.movie),
      ),
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
                  aspectRatio: 16 / 9,
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
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: new Container(
                          height: 72.0,
                          width: double.INFINITY,
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: <Color>[
                                const Color.fromARGB(200, 0, 0, 0),
                                Colors.transparent
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
                                            color: Colors.white70,
                                            decoration: TextDecoration.underline
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      new Text(
                                        _titles[i],
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
