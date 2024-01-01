import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'saved_quotes_class.dart';

class QuoteStorage {
  static const String key = 'saved_quotes';

  static Future<List<Quote>> getSavedQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? quotesJson = prefs.getString(key);
    if (quotesJson != null) {
      List<dynamic> quotesList = json.decode(quotesJson);
      List<Quote> quotes = quotesList.map((quote) => Quote.fromJson(quote)).toList();
      return quotes;
    } else {
      return [];
    }
  }

  static Future<void> saveQuote(Quote quote) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Quote> savedQuotes = await getSavedQuotes();
    savedQuotes.add(quote);
    String quotesJson = json.encode(savedQuotes.map((quote) => quote.toJson()).toList());
    await prefs.setString(key, quotesJson);
  }
 static Future<void> saveQuotes(List<Quote> quotes) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String quotesJson = json.encode(quotes.map((quote) => quote.toJson()).toList());
  await prefs.setString(key, quotesJson);
}

}
