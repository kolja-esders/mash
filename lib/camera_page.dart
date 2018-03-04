import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


class CameraApp extends StatefulWidget {
  CameraApp({Key key, this.cameras}) : super(key: key);

  List<CameraDescription> cameras;

  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.initialized) {
      return new Container();
    }

    return new Scaffold(
      body: new Column(
          children: <Widget>[
            new Expanded(
                child: new CameraPreview(controller)),
          ]),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => {},
        child: new Icon(Icons.image),
      ),
    );
  }
}
