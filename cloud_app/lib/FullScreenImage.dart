import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share/share.dart';
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

  Future<File> getApplicationDocumentsFile(
      String text, List<int> imageData) async {
    final directory = await getApplicationDocumentsDirectory();

    final exportFile = File('${directory.path}/$text.png');
    if (!await exportFile.exists()) {
      await exportFile.create(recursive: true);
    }
    final file = await exportFile.writeAsBytes(imageData);
    return file;
  }

  void shareImageAsStringAndText(String text, String image) async {
    //shareする際のテキスト
    try {
      //byte dataに
      Uint8List uints = Utility.dataFromBase64String(image);
      ByteData bytes = ByteData.view(uints.buffer);
      final widgetImageData =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //App directoryファイルに保存
      final applicationDocumentsFile =
          await getApplicationDocumentsFile(text, widgetImageData);

      final path = applicationDocumentsFile.path;
      await Share.shareFiles([path]);
      applicationDocumentsFile.delete();
    } catch (error) {
      print(error);
    }
  }
  void saveImageAsStringtoLocal(String _image) async{
    // 画像データの配列を取得
      Uint8List _buffer = Utility.dataFromBase64String(image);
      // アルバムに保存
      final result = await ImageGallerySaver.saveImage(_buffer);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('コレクション'),
        ),
        body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.all(20),
                    width: 300,
                    child: Utility.imageFromBase64String(image),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Icon(Icons.save_alt),
                        onPressed: () => {saveImageAsStringtoLocal(image)},
                      ),
                      ElevatedButton(
                        child: const Icon(Icons.share),
                        onPressed: () => {shareImageAsStringAndText('image', image)},
                      ),
                    ]),
              ])
        ),
      );
  }
}
