import 'package:cloud_app/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';
import 'Utility.dart';
import 'DBHelper.dart';
import 'Photo.dart';

class TakingPhoto extends StatefulWidget {
  @override
  _TakingPhoto createState() => _TakingPhoto();
}

class _TakingPhoto extends State<TakingPhoto> {
  File _image;
  int date;
  final picker = ImagePicker();
  DBHelper dbHelper;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyyMMddHm');
    date = int.parse(outputFormat.format(now));
    dbHelper = DBHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  _deleteDataInDB() {
    dbHelper.deleteDataInDB();
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future saveImg(imgFile) async {
    String imgString = Utility.base64String(await imgFile.readAsBytes());
    Photo photo = Photo(date, imgString);
    dbHelper.save(photo);
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
              Center(
                child: Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.all(20),
                  width: 300,
                  child: Center(
                      child: _image == null
                          ? const Text("雲を撮ろう！")
                          : Image.file(_image)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "hero1",
                    onPressed: getImageFromCamera, //カメラから画像を取得
                    tooltip: 'Pick Image From Camera',
                    child: Icon(Icons.add_a_photo),
                  ),
                  FloatingActionButton(
                    heroTag: "hero2",
                    onPressed: getImageFromGallery, //ギャラリーから画像を取得
                    tooltip: 'Pick Image From Gallery',
                    child: Icon(Icons.photo_library),
                  ),
                ],
              ),
              Container(
              color: Colors.transparent,
                margin: const EdgeInsets.all(20),
                child: _image == null
                    ? const SizedBox.shrink()
                    : ElevatedButton.icon(
                        label: const Text('結果を見る'),
                        icon: const Icon(Icons.cloud),
                        onPressed: () => {
                          saveImg(_image),
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Result(_image, date);
                          }))
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 50)),
                      ),
              ),
            ])
          )
        );
  }
}
