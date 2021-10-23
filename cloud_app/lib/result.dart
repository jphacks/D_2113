import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class Result extends StatelessWidget {
  Result(this._image);
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cloud Recognition'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: const Text('結果'),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 300,
                  child: Image.file(_image!)
                ),
              ]),
        ));
  }
}
