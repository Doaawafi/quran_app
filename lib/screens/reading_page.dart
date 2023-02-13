import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../models/surah.dart';

class SurahPage extends StatefulWidget {
  final Surah surah;

  const SurahPage({super.key, required this.surah});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);

  }

  @override
  Widget build(BuildContext context) {
    int count = widget.surah.versesCount;
    int index = widget.surah.id;
    int currentPage=0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.all(15),
          child:
          ListView(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: header(),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
              text: TextSpan(
                children: [
                  for (var i = 1; i <= count; i++) ...{
                    TextSpan(
                      text: ' ' +
                          quran.getVerse(index, i, verseEndSymbol: false) +
                          ' ',
                      style: const TextStyle(
                        fontFamily: 'Kitab',
                        fontSize: 25,
                        color: Colors.black87,
                      ),
                    ),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: CircleAvatar(
                          radius: 14,
                          child: Text(
                            '$i',
                            textAlign: TextAlign.center,
                            textScaleFactor: i.toString().length <= 2 ? 1 : .8,
                          ),
                        ))
                  }
                ],
              ),
            ),
          ]),
          // PageView.builder(
          //   itemCount: 114,
          //   controller: pageController,
          //   onPageChanged: (page) {
          //     setState(() {
          //       currentPage = page;
          //
          //     });
          //   },
          //   itemBuilder: (BuildContext context, int index) {
          //     if (index == currentPage) {
          //       return
          //         Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child:  Column(
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.all(5),
          //               child: header(),
          //             ),
          //             const SizedBox(
          //               height: 5,
          //             ),
          //             RichText(
          //               textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
          //               text: TextSpan(
          //                 children: [
          //                   for (var i = 1; i <= count; i++) ...{
          //                     TextSpan(
          //                       text: ' ' +
          //                           quran.getVerse(index, i, verseEndSymbol: false) +
          //                           ' ',
          //                       style: const TextStyle(
          //                         fontFamily: 'Kitab',
          //                         fontSize: 25,
          //                         color: Colors.black87,
          //                       ),
          //                     ),
          //                     WidgetSpan(
          //                         alignment: PlaceholderAlignment.middle,
          //                         child: CircleAvatar(
          //                           radius: 14,
          //                           child: Text(
          //                             '$i',
          //                             textAlign: TextAlign.center,
          //                             textScaleFactor: i.toString().length <= 2 ? 1 : .8,
          //                           ),
          //                         ))
          //                   }
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     }
          //     else {
          //       return const  Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
    Text(
      widget.surah.arabicName,
      style: TextStyle(
        fontFamily: 'Aldhabi',
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      ' ' + quran.basmala + ' ',
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'NotoNastaliqUrdu',
        fontSize: 24,
      ),
    ),
      ],
    );
  }
}
