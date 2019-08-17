import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakePhoto extends StatefulWidget {
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController controller;
  List<CameraDescription> cameras;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void loadData() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Scaffold(
        body: Center(
          child: Text('Habilite as permissões'),
        ),
      );
    }
    return new Stack(
      children: <Widget>[
        new CameraPreview(controller),
        new Positioned.fill(
            child: Container(
          child: Image.asset(
            'assets/camera_frame.png',
            fit: BoxFit.cover,
          ),
        ))
      ],
    );
  }
}
