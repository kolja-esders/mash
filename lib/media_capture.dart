import 'package:flutter/material.dart';
import 'mash_page.dart';


class MediaLocation extends StatefulWidget {
  MediaLocation({Key key, this.top, this.left, this.right, this.link, this.color, this.icon}) : super(key:key);
  final double top;
  final double left;
  final double right;
  final String link;
  final Color color;
  final Icon icon;

  @override
  _MediaLocationState createState() => new _MediaLocationState();
}


class _MediaLocationState extends State<MediaLocation> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      child: new Material(
        color: Colors.transparent,
        child: new IconButton(
          icon: widget.icon,
          iconSize: 32.0,
          color: widget.color,
          onPressed: () => Navigator.push(context, new MaterialPageRoute(
            builder: (_) => new MashPage(),
          ),
          ),
      ),
      ),
    );

  }
}




class MediaCapture extends StatefulWidget {
  MediaCapture({Key key, this.author, this.likes, this.avatar, this.link, this.icon, this.color}) : super(key:key);
  final String author;
  final int likes;
  final String avatar;
  final String link;
  final Icon icon;
  final Color color;


  @override
  _MediaCaptureState createState() => new _MediaCaptureState();

}



class _MediaCaptureState extends State<MediaCapture>{

  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[



          new Stack(
          alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  height: 52.0,
                  width: 52.0,
                  child: new Material(
                    borderRadius: new BorderRadius.all(
                        new Radius.circular(26.0)),
                    color: widget.color,
                  ),
                ),
                new CircleAvatar(
                  backgroundImage: new AssetImage(
                      'images/sarah.jpg'),
                  radius: 23.0,

                )

              ]),


              new Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: new Text(widget.author,
                      style: new TextStyle(color: Colors.grey)
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(right: 6.0),
                child: new Icon(
                  const IconData(0xe8dc, fontFamily: 'MaterialIcons'),
                  color: Colors.grey),
              ),
              new Container(
                margin: const EdgeInsets.only(right: 24.0),
                child: new Text(widget.likes.toString(),
                  style: new TextStyle(color: Colors.grey),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: new Material(
                  child: new IconButton(
                    icon: widget.icon,
                    iconSize: 32.0,
                    color: Colors.grey,
                    splashColor: Colors.blueAccent,
                    onPressed: () => Navigator.push(context, new MaterialPageRoute(
                      builder: (_) => new MashPage(),
                    ),
                  ),
                ),
                ),
                ),

      ]
      )
    );

        }

}