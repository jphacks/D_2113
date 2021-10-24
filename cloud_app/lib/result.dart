import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class Result extends StatelessWidget {
  Result(this._image);
  File _image;

  //path_providerでアプリ内のストレージ領域を確保
  static Future get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //SharePreferenceにimageのpathを書き込む
  static Future sharedPrefWrite(imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', imagePath);
  }

  // 画像をドキュメントへ保存する
  // 引数にはカメラ撮影時にreturnされるFileオブジェクトを持たせる
  static Future saveLocalImage(File image) async {
    final path = await localPath;
    final imagePath = '$path/image.png';
    //SharePreferenceで画像のストレージパスを保存
    sharedPrefWrite(imagePath);
    File imageFile = File(imagePath);
    // カメラで撮影した画像は撮影時用の一時的フォルダパスに保存されるため、その画像をドキュメントへ保存し直す
    var savedFile = await imageFile.writeAsBytes(await image.readAsBytes());
    return savedFile;
  }

  static Future shareImage(File image) async {
    final Uint8List bytes = await image.readAsBytes();
    await Share.file('タイトル', 'ファイル名', bytes, 'image/png',
        text: '本文');
  }

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
                    child: Image.file(_image)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Icon(Icons.save_alt),
                        onPressed: () => {shareImage(_image)},
                      ),
                      ElevatedButton(
                        child: const Icon(Icons.share),
                        onPressed: () => {},
                      ),
                    ]),
              ]),
        ));
  }
}
