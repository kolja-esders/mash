import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:share/share.dart';

import 'package:mash/comment.dart';
import 'map.dart';

class MashPageState extends State<MashPage> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  bool _verified = false;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    _controller = new VideoPlayerController(
      'https://github.com/kolja-esders/mash/blob/master/videos/faked.mp4?raw=true',
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Material(
                  elevation: 2.0,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        child: new Material(
                          color: Colors.black,
                        ),
                        height: 24.0,
                        width: double.INFINITY,
                      ),
                      new Stack(
                        children: <Widget>[
                          new AspectRatio(
                            aspectRatio: 1280 / 720,
                            child: new VideoPlayer(_controller),
                          ),
                          new AspectRatio(
                            aspectRatio: 1280 / 720,
                            child: new Center(
                              child: new Icon(
                                _controller.value.isPlaying ? null : Icons
                                    .play_arrow,
                                color: Colors.white,
                                size: 96.0,
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
                          new GestureDetector(
                              onTap: _controller.value.isPlaying ? _controller
                                  .pause : _controller.play,
                              child: new AspectRatio(
                                  aspectRatio: 1280 / 720,
                                  child: new Material(
                                    color: Colors.transparent,
                                  )
                              )
                          ),
                          new Positioned(
                            left: 0.0,
                            bottom: 0.0,
                            child:
                            new Material(
                                color: Colors.transparent,
                                child: new Container(
                                  width: 190.0,
                                  height: 72.0,
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      new IconButton(
                                        onPressed: () =>
                                            setState(() {
                                              _liked = !_liked;
                                            }),
                                        icon: new Icon(
                                            _liked ? Icons.favorite : Icons
                                                .favorite_border),
                                        color: _liked
                                            ? Colors.redAccent
                                            : Colors.white,
                                        splashColor: Colors.redAccent,
                                      ),
                                      new IconButton(
                                        onPressed: () =>
                                            setState(() {
                                              _verified = !_verified;
                                            }),
                                        icon: new Icon(Icons.verified_user),
                                        color: _verified
                                            ? Colors.blueAccent
                                            : Colors.white,
                                        splashColor: Colors.blueAccent,
                                      ),
                                      new IconButton(
                                        onPressed: () =>
                                            share('test'),
                                        icon: new Icon(Icons.share),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          new Positioned(
                              bottom: 16.0,
                              right: 16.0,
                              child: new GestureDetector(
                                onTap: () => print('test'),
                                child: new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 24.0,
                                  child: new Text('JD'),
                                ),
                              )
                          ),
                          new Positioned(
                            top: -16.0,
                            right: -16.0,
                            child: new Material(
                              color: Colors.transparent,
                              child: new Container(
                                  padding: new EdgeInsets.all(16.0),
                                  child: new IconButton(
                                    icon: new Icon(Icons.more_vert),
                                    onPressed: () => Navigator.push(context, new MaterialPageRoute(
                                      builder: (_) => new MapPage(),
                                      ),
                                    ),
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                      new Container(
                        padding: new EdgeInsets.all(16.0),
                        width: double.INFINITY,
                        child: new Text(
                          'Olympic Winter Games 2018',
                          style: new TextStyle(
                              fontSize: 24.0
                          ),
                        ),
                      )
                    ],
                  )
              ),
              new Expanded(
                  child: new ListView(
                    padding: new EdgeInsets.all(16.0),
                    children: <Widget>[
                      new Comment(
                          key: new Key('x'),
                          avatar: '-',
                          author: 'HM',
                          content: 'This is a comment!',
                          color: Colors.blueAccent
                      ),
                      new Comment(
                          key: new Key('y'),
                          avatar: '-',
                          author: 'JD',
                          content: 'Fucking amazing!',
                          color: Colors.greenAccent
                      ),
                      new Comment(
                          key: new Key('z'),
                          avatar: '-',
                          author: 'LJ',
                          content: 'Liiiiiit bro.',
                          color: Colors.redAccent
                      )
                    ],
                  )
              ),
              new Container(
                  child: new Container(
                      color: Colors.white,
                      alignment: Alignment.bottomCenter,
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.only(
                                left: 16.0, top: 8.0, bottom: 8.0),
                            child: new CircleAvatar(
                                backgroundColor: Colors.red,
                                child: new Text('AJ')
                            ),
                          ),
                          new Expanded(
                              child: new Container(
                                  child: new TextField(
                                    keyboardType: TextInputType.text,
                                    autocorrect: false,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type something',
                                      contentPadding: new EdgeInsets.all(16.0),
                                    ),
                                  )
                              )
                          )
                        ],
                      )
                  )
              )
            ]
        ),
        backgroundColor: new Color.fromARGB(255, 220, 220, 220)
    );
  }
}

class MashPage extends StatefulWidget {
  MashPage({Key key, this.title, this.author}) : super(key: key);

  final String title;
  final String author;

  @override
  MashPageState createState() => new MashPageState();
}