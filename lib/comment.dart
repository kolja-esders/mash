import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  Comment({Key key, this.avatar, this.author, this.content, this.color}) : super(key: key);
  final String author;
  final String avatar;
  final String content;
  final Color color;

  @override
  CommentState createState() => new CommentState();
}


class CommentState extends State<Comment> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(bottom: 16.0),
        child: new Row(
          children: <Widget>[
            new CircleAvatar(
              backgroundColor: widget.color,
              child: new Text(widget.author)
            ),
            new Expanded(
                child: new Container(
                    margin: new EdgeInsets.only(left: 8.0),
                    padding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(24.0)),
                        color: Colors.white
                    ),
                    child: new Text(widget.content)
                )
            )
          ],
        )
    );
  }
}