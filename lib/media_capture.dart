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
      child: new IconButton(
        icon: widget.icon,
        iconSize: 32.0,
        color: widget.color,
        splashColor: Colors.blueAccent,
        onPressed: () => Navigator.push(context, new MaterialPageRoute(
          builder: (_) => new MashPage(),
        ),
        ),
      ),
    );

  }
}




class MediaCapture extends StatefulWidget {
  MediaCapture({Key key, this.author, this.likes, this.avatar, this.link, this.icon}) : super(key:key);
  final String author;
  final int likes;
  final String avatar;
  final String link;
  final int icon;


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

              new Container(
                child: new CircleAvatar(
                    backgroundImage: new AssetImage(widget.link),
                    radius: 24.0,
                ),
              ),
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
                child: new IconButton(
                  icon: new Icon(const IconData(0xe039, fontFamily: 'MaterialIcons')),
                  iconSize: 32.0,
                  color: Colors.grey,
                  splashColor: Colors.blueAccent,
                  onPressed: () => Navigator.push(context, new MaterialPageRoute(
                    builder: (_) => new MashPage(),
                ),
                ),
                ),

                ),


          /* new Container(
            margin: const EdgeInsets.only(left: 6.0),

            ),
          ),
          */
    ]
      )
    );

        }
 /*
      )
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) => new EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
*/

}








/*
// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, this.number_of_likes);
  final String title;
  final int number_of_likes;


}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  new Entry('Klaus Kleber', 50),
  new Entry('Jan Böhmer', 23),
  new Entry('Marc Bator', 13),

];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {

      return new Container(
          title: new Text(root.title),
          likes: new Text(root.number_of_likes.toString()));

  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
*/