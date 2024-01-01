import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/model/appstate.dart';

import '../constants.dart';
import '../model/saved_quotes.dart';
import '../model/saved_quotes_class.dart';
import 'quotes.dart';
import 'dart:math';

class Saved_quotes extends StatefulWidget {
  const Saved_quotes({super.key});

  @override
  State<Saved_quotes> createState() => _Saved_quotesState();
}

class _Saved_quotesState extends State<Saved_quotes> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savedQuotes();
    print(savedquotes.length);
    // final model = Provider.of<AppStateModel>(context,listen: false);
    // model.savedQuotes;
    // print("Ayush");
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final model = Provider.of<AppStateModel>(context, listen: false);
    //       model.savedQuotes;
    //           print(model.savedquotesList);

    // });
  }

  List<Quote> savedquotes = [];

  savedQuotes() async {
    final prefs = await QuoteStorage.getSavedQuotes();
    setState(() {
      savedquotes = prefs;
    });
  }

  removeQuotes(int index) async {
    final prefs = await QuoteStorage.getSavedQuotes();
    // setState()async {
    //   savedquotes.removeAt(index);
    //   await prefs.setStringList('saved_quotes', savedquotes);
    // };
    prefs.removeAt(index);

    // Save the updated list back to SharedPreferences
    await QuoteStorage.saveQuotes(prefs);

    setState(() {
      savedquotes = prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return savedquotes.length > 0
          ? ListView.builder(
              itemCount: savedquotes.length,
              itemBuilder: (context, index) {
                Color bgColor =
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0);
                return Center(
                    child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        key: UniqueKey(),
                        width: 350,
                        height: 380,
                        decoration: BoxDecoration(color: bgColor),
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
                                    fontFamily:
                                        GoogleFonts.mrBedfort().fontFamily,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Center(
                                    child: Text(
                                  savedquotes[index].text,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              Center(
                                child: Text(
                                  savedquotes[index].author!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
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
                                        index,
                                        savedquotes[index].text,
                                        savedquotes[index].author);
                                  },
                                  child: Icon(
                                    IconlyLight.send,
                                    size: 24,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    model.saveQuote(index);
                                    Constants.isSaved == true
                                        ? Fluttertoast.showToast(
                                            msg: "Saved to Gallery",
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                            textColor: Colors.black)
                                        : null;
                                  },
                                  child: Icon(
                                    IconlyLight.download,
                                    size: 24,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    removeQuotes(index);
                                    Constants.isSaved == true
                                        ? Fluttertoast.showToast(
                                            msg: "Removed",
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                            textColor: Colors.black)
                                        : null;
                                  },
                                  child: Icon(
                                    IconlyLight.delete,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                    // : Center(child: Text('No quotes found')),
                    SizedBox(height: 20),
                  ],
                ));
              })
          : Center(child: Text('No quotes found'));
    });
  }
}
