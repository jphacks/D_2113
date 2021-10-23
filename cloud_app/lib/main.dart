import 'package:cloud_app/collection.dart';
import 'package:cloud_app/takingPhoto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cloud Recognition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                label: const Text('雲を撮る'),
                icon: const Icon(Icons.camera_alt),
                onPressed: () => {
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                      return TakingPhoto();
                    }))
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 50)
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                label: const Text('コレクション'),
                icon: const Icon(Icons.insert_photo),
                onPressed: () => {
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                      return Collection();
                    }))
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 50)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
