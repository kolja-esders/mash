import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';

import 'package:mash/mash_page.dart' as mash;

import 'overview.dart' as overview;
import 'profile_page.dart' as profile;
import 'camera_page.dart' as camera;


List<CameraDescription> cams = [];

Future<Null> main() async {
  if(cams.length == 0) {
    cams = await availableCameras();
  }
  runApp(new MyApp());
}

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        bottomNavigationBar: new Material(
            color: Colors.blue,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.camera_alt)),
                  new Tab(icon: new Icon(Icons.home)),
                  new Tab(icon: new Icon(Icons.person)),
                ]
            )
        ),
        body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new camera.CameraApp(cameras: cams,),
              new overview.MyHomePage(title: "Mash",),
              new profile.ProfilePage(
                name: "Sarah Engels",
                avatar: "images/sarah.jpg",
              ),
            ]
        )
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyTabs(),
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
                  builder: (_) => new overview.MyHomePage(title: 'Flutter'),
                  settings: settings
              );
            case 'mash':
              return new MaterialPageRoute(
                  builder: (_) => new mash.MashPage(),
                  settings: settings
              );
          }
        }
    );
  }
}
