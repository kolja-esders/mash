import 'package:flutter/material.dart';

import 'mash_tile.dart';

class ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverToBoxAdapter(
              child:
              new Container(
                child: new Column(
                    children: <Widget>[
                      new Stack(
                          children: <Widget>[
                            new Container(
                              decoration: new BoxDecoration(
                                gradient: new RadialGradient(
                                  center: const Alignment(1.0, 2.0),
                                  radius: 2.0,
                                  colors: [
                                    const Color(0xfff80759),
                                    const Color(0xffbc4e9c),
                                  ],
                                  stops: [0.4, 1.0],
                                ),
                              ),
                              width: double.INFINITY,
                              height: 200.0,
                              margin: new EdgeInsets.only(bottom: 90.0),
                            ),
                            new Positioned(
                              top: 40.0,
                              right: 16.0,
                              child: new Icon(
                                Icons.edit,
                                color: Colors.white70,
                              ),
                            ),
                            new Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: new Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      new Container(
                                        height: 152.0,
                                        width: 152.0,
                                        child: new Material(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(76.0)),
                                          color: new Color.fromARGB(
                                              255, 240, 240, 240),
                                        ),
                                      ),
                                      new CircleAvatar(
                                        backgroundImage: new AssetImage(
                                            'images/sarah.jpg'),
                                        radius: 72.0,

                                      )

                                    ])
                            )
                          ]
                      ),
                      new Container(
                          margin: new EdgeInsets.only(top: 16.0),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                    widget.name,
                                    style: new TextStyle(
                                      fontSize: 32.0,
                                    )
                                ),
                                new Icon(
                                    Icons.verified_user,
                                    color: Colors.blueAccent
                                )
                              ])
                      ),
                      new Container(
                        alignment: Alignment.center,
                        margin: new EdgeInsets.only(top: 8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(
                                Icons.star,
                                color: new Color(0xfff80759)
                            ),
                            new Icon(
                                Icons.star,
                                color: new Color(0xfff80759)
                            ),
                            new Icon(
                                Icons.star,
                                color: new Color(0xfff80759)
                            ),
                            new Icon(
                                Icons.star,
                                color: new Color.fromARGB(255, 210, 210, 210)
                            ),
                            new Icon(
                                Icons.star,
                                color: new Color.fromARGB(255, 210, 210, 210)
                            ),
                          ],
                        ),
                      ),
                      new Container(
                          alignment: Alignment.centerLeft,
                          margin: new EdgeInsets.only(top: 16.0),
                          padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: new Text(
                              'Submitted mashes',
                            style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: Colors.black54
                            )
                          )
                      ),
                    ]

                ),
              ),
            ),
            new SliverPadding(
              padding: new EdgeInsets.all(4.0),
              sliver: new SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.0,
                children: <String>[
                  'images/ski.jpg',
                  'images/rings.jpg',
                  'images/cheer.jpg',
                ].map((String path) {
                  return new GridTile(
                      child: new Container(
                          height: 100.0,
                          child: new Image.asset(path, fit: BoxFit.cover)
                      ),
                      footer: new Material(
                          color: Colors.black54,
                          child: new Container(
                              padding: new EdgeInsets.all(16.0),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        new Text(
                                          'Awesome test',
                                          style: new TextStyle(
                                              fontWeight: FontWeight
                                                  .w500,
                                              fontSize: 16.0,
                                              color: Colors.white
                                          ),
                                        ),
                                        new Text(
                                          'Subtitle',
                                          style: new TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  new Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,)
                                ],
                              )
                          )
                      )
                  );
                }).toList(),
              ),
            )
          ],
        )
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.name, this.avatar}) : super(key: key);

  final String name;
  final String avatar;

  @override
  ProfilePageState createState() => new ProfilePageState();
}