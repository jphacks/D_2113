import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraint) {
      final height = contraint.maxHeight;
      final width = contraint.maxWidth;
      return Stack(
       children: <Widget>[Container(
           color: Color(0xFFE4E6F1),
         ),
       ],
     );
   });
  }
}
