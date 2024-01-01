import 'package:flutter/material.dart';

Widget Success(){
  return Row(
            mainAxisSize: MainAxisSize.min,

    children: [
      Icon(Icons.check),
            SizedBox(
            width: 12.0,
            ),
            Text("This is a Custom Toast"),
    ],
  );
}