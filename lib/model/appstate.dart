import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widget/quotes.dart';
import 'all_quotes.dart';
import 'saved_quotes.dart';
import 'saved_quotes_class.dart';

class AppStateModel extends ChangeNotifier {
  int currentIndex = 0;
  List<Quote> savedquotesList = [];

  savedQuotes() async {
    final prefs = await QuoteStorage.getSavedQuotes();
    savedquotesList = prefs;
    notifyListeners();
  }

  static void shareQuote(index) {
    final shareQuotes = '"' +
        Quotes.quotes[index].q.toString() +
        '"' +
        '\n' +
        '- ' +
        Quotes.quotes[index].a.toString();
    Share.share(shareQuotes);
  }

  void saveQuote(index) {
    Constants.screenshotController
        .captureFromWidget(
            SaveQuotes(Quotes.quotes[currentIndex].q, Quotes.quotes[index].a),
            pixelRatio: 8)
        .then((Uint8List image) async {
      if (image != null) {
        final result =
            await ImageGallerySaver.saveImage(image.buffer.asUint8List());
        if (result['isSuccess'] == true) {
          Constants.isSaved = true;
        } else {
          Constants.isSaved = false;
        }
        // print(Constants.isSaved);
      }
    });
  }

  //Saved Quotes Function
  static void saved_shareQuote(index, quotes_text, author) {
    final shareQuotes =
        '"' + quotes_text.toString() + '"' + '\n' + '- ' + author.toString();
    Share.share(shareQuotes);
  }

  void saved_saveQuote(index) {
    Constants.screenshotController
        .captureFromWidget(
            SaveQuotes(Quotes.quotes[currentIndex].q, Quotes.quotes[index].a),
            pixelRatio: 8)
        .then((Uint8List image) async {
      if (image != null) {
        final result =
            await ImageGallerySaver.saveImage(image.buffer.asUint8List());
        if (result['isSuccess'] == true) {
          Constants.isSaved = true;
        } else {
          Constants.isSaved = false;
        }
        // print(Constants.isSaved);
      }
    });
  }

  void changeIndex(newIndex) {
    currentIndex = newIndex;
    notifyListeners(); // Notify listeners to trigger a rebuild
  }
}
