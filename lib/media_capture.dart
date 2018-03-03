import 'package:flutter/material.dart';



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


class MediaCapture extends StatefulWidget {
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
    return new Scaffold(
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) => new EntryItem(data[index]),
          itemCount: data.length,
        ),
    );
  }
}