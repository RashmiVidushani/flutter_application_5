import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/Dones/cameraview.dart';
import 'package:flutter_application_5/Dones/videoview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

late List<CameraDescription> cameras;

class CamaraScreen extends StatefulWidget {
  const CamaraScreen({Key? key, this.onImageSend}) : super(key: key);
  final Function? onImageSend;
  @override
  State<CamaraScreen> createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = false;
  double transform = 0;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
            bottom: 0.0,
            child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                flash = !flash;
                              });
                              flash
                                  ? _cameraController
                                      .setFlashMode(FlashMode.torch)
                                  : _cameraController
                                      .setFlashMode(FlashMode.off);
                            },
                            icon: Icon(
                              flash ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                              size: 28,
                            )),
                        GestureDetector(
                            onLongPress: () async {
                              await _cameraController.startVideoRecording();
                              setState(() {
                                isRecording = true;
                              });
                            },
                            onLongPressUp: () async {
                              XFile videopath =
                                  await _cameraController.stopVideoRecording();
                              setState(() {
                                isRecording = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          VideoView(path: videopath.path)));
                            },
                            onTap: () {
                              if (!isRecording) {
                                takePhoto(context);
                              }
                            },
                            child: isRecording
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: Colors.red,
                                    size: 80,
                                  )
                                : Icon(
                                    Icons.panorama_fish_eye,
                                    color: Colors.white,
                                    size: 70,
                                  )),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                iscamerafront = !iscamerafront;
                                transform = transform + pi;
                              });
                              int cameraPos = iscamerafront ? 0 : 1;
                              _cameraController = CameraController(
                                  cameras[0], ResolutionPreset.high);
                              cameraValue = _cameraController.initialize();
                            },
                            icon: Transform.rotate(
                                angle: transform,
                                child: Icon(
                                  Icons.flip_camera_ios,
                                  color: Colors.white,
                                  size: 28,
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Hold fo video, tap for photo",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  ],
                )))
      ],
    ));
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => CameraView(
          path: file.path,
          onImageSend: widget.onImageSend,
        ),
      ),
    );
  }
}
//12