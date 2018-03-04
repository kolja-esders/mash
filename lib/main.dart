import 'package:flutter/material.dart';

import 'mash_page.dart';
import 'overview.dart' as overview;


void main() => runApp(new MyApp());


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
            color: Colors.deepOrange,
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
              new overview.MyApp(),
              new overview.MyApp(),
              new overview.MyApp(),
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
          primarySwatch: Colors.deepOrange,
        ),
        home: new MyTabs(),
    );
  }
}
