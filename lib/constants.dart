import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'model/saved_quotes_class.dart';

class Constants{
  static String base_url = "https://zenquotes.io/api";
  static String allquotes_url = "https://zenquotes.io/api"+"/quotes";
  static bool? isSaved;
  static   ScreenshotController screenshotController = ScreenshotController(); 
  static List<Color>? quoteColors;
  static List<Quote> savedquotes = [];

}
class Routes{
   static final String splash= "/";
  static final String home = "/home"; 
}