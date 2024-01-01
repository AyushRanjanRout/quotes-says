import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:math' as math;

import '../constants.dart';
import '../model/all_quotes.dart';
import '../model/appstate.dart';
import '../model/saved_quotes.dart';

class QuotesBOX extends StatelessWidget {
  QuotesBOX(
      {super.key,
      required this.quotes_text,
      required this.bg_color,
      required this.author});
  String? quotes_text;
  String? author;
  Color bg_color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        key: UniqueKey(),
        width: 350,
        height: 380,
        decoration: BoxDecoration(color: bg_color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: Text(
                ' "',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontFamily: GoogleFonts.mrBedfort().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Center(
                  child: Text(
                quotes_text!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ),
            Center(
              child: Text(
                author!,
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget SaveQuotes(quotes_text, author) {
  return Screenshot(
    controller: Constants.screenshotController,
    child: Container(
      key: UniqueKey(),
      width: 350,
      height: 380,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Text(
              ' "',
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontFamily: GoogleFonts.mrBedfort().fontFamily,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Center(
                child: Text(
              quotes_text!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
          ),
          Center(
            child: Text(
              author!,
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget mySavedQuotes(
    BuildContext context, quotes_text, author, bg_color, currentIndex) {
  final model = Provider.of<AppStateModel>(context);
  // final currentIndex = model.currentIndex;
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
      key: UniqueKey(),
      width: 350,
      height: 380,
      decoration: BoxDecoration(color: bg_color),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: Text(
                ' "',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontFamily: GoogleFonts.mrBedfort().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Center(
                  child: Text(
                quotes_text!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ),
            Center(
              child: Text(
                author!,
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  AppStateModel.saved_shareQuote(
                      currentIndex, quotes_text, author);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      IconlyLight.send,
                      size: 24,
                    ),
                    Text(" Share  ")
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  model.saveQuote(currentIndex);
                  Constants.isSaved == true
                      ? Fluttertoast.showToast(
                          msg: "Saved to Gallery",
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          textColor: Colors.black)
                      : null;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      IconlyLight.download,
                      size: 24,
                    ),
                    Text(" Download")
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    ),
  );
}
