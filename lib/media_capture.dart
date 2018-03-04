import 'package:flutter/material.dart';
import 'mash_page.dart';


class MediaCapture extends StatefulWidget {
  MediaCapture({Key key, this.author, this.likes, this.avatar, this.link}) : super(key:key);
  final String author;
  final int likes;
  final String avatar;
  final String link;


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
          new Expanded(
            child: new Row(
              children: <Widget>[
              new Container(
                child: new CircleAvatar(
                  child: new Text(widget.likes.toString()),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: new Text(widget.author),
              ),
            ]
            ),
          ),

              new Container(
                margin: const EdgeInsets.only(right: 6.0),
                child: new Icon(const IconData(0xe8dc, fontFamily: 'MaterialIcons')),
              ),
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new Text(widget.likes.toString()),
              ),

              new Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: new Icon(const IconData(0xe039, fontFamily: 'MaterialIcons')),


                ),


          /* new Container(
            margin: const EdgeInsets.only(left: 6.0),
            child: new IconButton(
              icon: new Icon(const IconData(0xe039, fontFamily: 'MaterialIcons')),
              onPressed: () => Navigator.push(context, new MaterialPageRoute(
                builder: (_) => new MashPage(),
              ),
              ),
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