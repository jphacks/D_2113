import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'DBHelper.dart';

class Result extends StatelessWidget {
  Result(this._image, this.id);
  File _image;
  int id;
  DBHelper dbHelper = DBHelper();

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

  void shareImageAndText(String text, File image) async {
    //shareする際のテキスト
    try {
      //byte dataに
      Uint8List uints = image.readAsBytesSync();
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
  void saveImagetoLocal(File _image) async{
    // 画像データの配列を取得
      Uint8List _buffer = await _image.readAsBytes();
      // アルバムに保存
      final result = await ImageGallerySaver.saveImage(_buffer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Cloud Recognition'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('結果'),
                Container(
                    margin: const EdgeInsets.all(20),
                    width: 300,
                    child: Image.memory(
                      _image.readAsBytesSync(),
                    ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Icon(Icons.save_alt),
                        onPressed: () => {saveImagetoLocal(_image)},
                      ),
                      ElevatedButton(
                        child: const Icon(Icons.share),
                        onPressed: () => {shareImageAndText('image', _image)},
                      ),
                    ]),
              ]),
        ));
  }
}
