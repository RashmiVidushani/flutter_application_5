import 'dart:io';

import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({
    Key? key,
    required this.path,
    this.onImageSend,
  }) : super(key: key);
  final String path;
  final Function? onImageSend;
  static TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.crop_rotate,
            size: 27,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.emoji_emotions,
            size: 27,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.title,
              size: 27,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              size: 27,
            ))
      ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              /* child: Image.file(
                  File(path),
                  fit: BoxFit.cover,
                )
                */
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.black38,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    maxLines: 6,
                    minLines: 1,
                    decoration: InputDecoration(
                        hintText: "Add Caption",
                        prefixIcon: Icon(Icons.add_a_photo,
                            color: Colors.white, size: 27),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                        suffixIcon: InkWell(
                            onTap: () {
                              onImageSend!(path, _controller.text.trim());
                            },
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.tealAccent[700],
                              child: Icon(Icons.check, color: Colors.white),
                            ))),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
