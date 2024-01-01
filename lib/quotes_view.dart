import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:iconly/iconly.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/model/appstate.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math' as math;

import 'api/main_call.dart';
import 'constants.dart';
import 'model/all_quotes.dart';
import 'model/saved_quotes.dart';
import 'model/saved_quotes_class.dart';
import 'widget/quotes.dart';
import 'widget/toast.dart';

class Quotes_View extends StatefulWidget {
  Quotes_View({super.key});

  @override
  State<Quotes_View> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes_View> {
  late List<Color> quoteColors;
  Future<List<All_Quotes>>? quotesFuture;

  @override
  void initState() {
    super.initState();
    // Generate random colors for each QuotesBOX
    quoteColors = List.generate(300, (index) {
      return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
    quotesFuture = ApiCall.loadQuotes();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final currentIndex = model.currentIndex;
    final CardSwiperController controller = CardSwiperController();
    return Center(
      child: FutureBuilder(
          future: quotesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                        height: 380,
                        child:
                            Consumer(builder: (context, AppStateModel, child) {
                          return CardSwiper(
                            controller: controller,
                            cardsCount: Quotes.quotes.length,
                            onSwipe: (
                              int previousIndex,
                              var nowIndex,
                              CardSwiperDirection direction,
                            ) {
                              model.changeIndex(nowIndex);
                              return true;
                            },
                            numberOfCardsDisplayed: 3,
                            backCardOffset: const Offset(0, 30),
                            padding: const EdgeInsets.all(24.0),
                            cardBuilder: (
                              context,
                              index,
                              horizontalThresholdPercentage,
                              verticalThresholdPercentage,
                            ) {
                              var randomColor = quoteColors[index];

                              return QuotesBOX(
                                  bg_color: randomColor,
                                  key: ValueKey<int>(index),
                                  quotes_text: Quotes.quotes[index].q,
                                  author: Quotes.quotes[index].a);

                            },
                          );
                        })),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          await QuoteStorage.saveQuote(Quote(author: Quotes.quotes[currentIndex].a as String, text:  Quotes.quotes[currentIndex].q as String));
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Icon(
                          IconlyBroken.heart,
                          size: 24,
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                      MaterialButton(
                        onPressed: () {
                          AppStateModel.shareQuote(currentIndex);
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Icon(
                          IconlyLight.send,
                          size: 24,
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                      MaterialButton(
                        onPressed: () {
                          model.saveQuote(currentIndex);
                          Constants.isSaved == true
                              ? Fluttertoast.showToast(
                                  msg: "Saved to Gallery",
                                  backgroundColor:
                                      ui.Color.fromARGB(255, 255, 255, 255),
                                  textColor: Colors.black)
                              : null;
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Icon(
                          IconlyLight.download,
                          size: 24,
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      )
                    ],
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
