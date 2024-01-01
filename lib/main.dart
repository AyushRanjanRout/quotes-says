import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'model/appstate.dart';
import 'splash_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuotesSays',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  Home(),
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
      },
    );
  }
}
