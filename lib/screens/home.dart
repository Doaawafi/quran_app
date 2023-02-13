import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/screens/reading_page.dart';

import '../models/surah.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    debugPrint(surahList.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        leading: Transform.rotate(
          angle: isReverse ? pi : 2 * pi,
          child: IconButton(
              icon:  Icon(Icons.sort,color: Colors.blue.shade400,size: 35,),
              onPressed: () {
                setState(() {
                  isReverse = !isReverse;
                });
              }),
        ),
        title: Text('سور القرأن الكريم ',style:GoogleFonts.montserrat(color: Colors.black)),
        centerTitle: true,
        actions:  [
          Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/%D8%A7%D9%84%D9%82%D8%B1%D8%A7%D9%86_%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85_-_%D8%B4%D8%B9%D8%A7%D8%B1_%D8%A7%D9%84%D9%82%D8%B1%D8%A2%D9%86_%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85_-_%D9%84%D9%88%D8%BA%D9%88_%D8%A7%D9%84%D9%82%D8%B1%D8%A2%D9%86_%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85_-_logo_quran.svg/2005px-%D8%A7%D9%84%D9%82%D8%B1%D8%A7%D9%86_%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85_-_%D8%B4%D8%B9%D8%A7%D8%B1_%D8%A7%D9%84%D9%82%D8%B1%D8%A2%D9%86_%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85_-_%D9%84%D9%88%D8%BA%D9%88_%D8%A7%D9%84%D9%82%D8%B1%D8%A2%D9%86_%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85_-_logo_quran.svg.png'),
          const SizedBox(width: 20,),
          // Icon(Icons.mosque,color: Colors.brown,),

        ],
      ),
      body: surahList.isEmpty
          ?  Center(child: CircularProgressIndicator(color: Colors.blue.shade600,))
          : chaptersList(isReverse ? surahList.reversed.toList() : surahList,),
    );
  }

  Widget chaptersList(List<Surah> chapters) {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) =>
          ListTile(
                   hoverColor: Colors.lightBlue.shade100,
                   leading: CircleAvatar(
                     backgroundColor: Colors.lightBlue,
                     child: Text(chapters[index].id.toString(),style: const TextStyle(color: Colors.white),),
                   ),
                   title: Text(chapters[index].name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                   subtitle: Text("${chapters[index].versesCount.toString()}  : عدد الأيات ",style:  TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w300),),
                   trailing: Text(
          chapters[index].arabicName,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue

          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                SurahPage(surah: chapters[index]),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(height: 1,color: Colors.black12,thickness: 1),
      itemCount: chapters.length,
    );
  }
}
