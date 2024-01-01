import 'dart:convert';

import 'package:quotes_app/constants.dart';
import 'package:http/http.dart' as http;

import '../model/all_quotes.dart';

class ApiCall {
  static Future<List<All_Quotes>> loadQuotes() async {
    final res = await http.get(Uri.parse(Constants.allquotes_url));
    final all_quotes = jsonDecode(res.body);
    Quotes.quotes = List.from(all_quotes)
        .map<All_Quotes>((item) => All_Quotes.fromMap(item))
        .toList();
    return Quotes.quotes!;
    print(jsonDecode(res.body));
  }
}
