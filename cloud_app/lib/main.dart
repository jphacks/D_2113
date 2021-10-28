import 'package:cloud_app/collection.dart';
import 'package:cloud_app/takingPhoto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const MyHomePage(title: 'Cloud Recognition'),
        ]
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                label: const Text('撮る'),
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
              color: Colors.transparent,
              margin: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                label: const Text('見る'),
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
