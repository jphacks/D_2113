import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'Utility.dart';

class FullScreenImage extends StatefulWidget {
  final String image;
  final int index;

  FullScreenImage({this.image, this.index});

  @override
  State<StatefulWidget> createState() => _FullScreenImage(image, index);
}

class _FullScreenImage extends State<FullScreenImage> {
  String image;
  int index;

  _FullScreenImage(this.image, this.index);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('コレクション'),
        ),
        body: Container(
          color: Colors.white,
          child: Utility.imageFromBase64String(image),
        ),
      ),
    );
  }
}
