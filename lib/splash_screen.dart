import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: TextSpan(
              style: TextStyle(
                  fontFamily: GoogleFonts.dancingScript().fontFamily,
                  fontSize: 55),
              children: [
                TextSpan(text: "Quotes", style: TextStyle(color: Colors.black)),
                TextSpan(text: "Says", style: TextStyle(color: Colors.red))
              ]),
        ),
      ),
    );
  }
}
