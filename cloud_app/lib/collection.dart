import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'Utility.dart';
import 'DBHelper.dart';
import 'Photo.dart';
import 'FullScreenImage.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    refreshImages();
  }

  _deleteDataInDB() {
    dbHelper.deleteDataInDB();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  getPhotData(int id) {
    dbHelper.getPhoto(id).then((imgs) {
      if (imgs.isNotEmpty) {
        return imgs[0].photo_data;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('コレクション'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteDataInDB();
              refreshImages();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child:
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Hero(
                      tag: images[index].id,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: Utility.imageFromBase64String(images[index].photo_data),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                          return FullScreenImage(image: images[index].photo_data, index: images[index].id);
                          }
                        ),
                      );
                    }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
