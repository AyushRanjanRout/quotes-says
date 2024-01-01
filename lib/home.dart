import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'quotes_view.dart';
import 'widget/saved_quotes.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: RichText(
          text: TextSpan(
              style: TextStyle(
                  fontFamily: GoogleFonts.dancingScript().fontFamily,
                  fontSize: 30),
              children: [
                TextSpan(text: "Quotes", style: TextStyle(color: Colors.black)),
                TextSpan(text: "Says", style: TextStyle(color: Colors.red))
              ]),
        ),
      )),
      body: SafeArea(
          child: IndexedStack(
              index: _selectIndex, children: [Quotes_View(), Saved_quotes()])),
      bottomNavigationBar: NavigationBar(
          elevation: 0,
          height: 65,
          onDestinationSelected: (value) {
            setState(() {
              _selectIndex = value;
            });
          },
          selectedIndex: _selectIndex,
          destinations: [
            NavigationDestination(icon: Icon(IconlyBroken.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(IconlyBroken.heart), label: 'Saved'),
          ]),
    );
  }
}
