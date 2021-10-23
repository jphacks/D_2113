import 'package:cloud_app/result.dart';
import 'package:flutter/material.dart';

class TakingPhoto extends StatelessWidget {
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
              margin: const EdgeInsets.all(10),
              child: const Text("雲を撮ろう！"),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                label: const Text('結果を見る'),
                icon: const Icon(Icons.cloud),
                onPressed: () => {
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                      return Result();
                    }))
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 50)
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}
