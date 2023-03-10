// import 'dart:convert';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//
//   runApp(
//     EasyLocalization(
//         supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
//         path: 'assets',
//         fallbackLocale: Locale('en', 'US'),
//         child: MyApp()),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: context.supportedLocales,
//       locale: context.locale,
//       title: 'Quran App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int currentPage = 1;
//   bool isLoading = false;
//   dynamic data;
//
//   late PageController pageController;
//
//   getData(int page) async {
//     data = [];
//     http.Response response = await http.get(
//       Uri.parse('http://api.alquran.cloud/v1/page/$page/quran-uthmani'),
//     );
//
//     var result = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       setState(() {
//         isLoading = true;
//         data = result['data']['ayahs'] as List;
//       });
//     }
//     return null;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     pageController = PageController(initialPage: 1);
//     getData(currentPage);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: !isLoading
//             ? const CircularProgressIndicator()
//             : SafeArea(
//           child:
//           PageView.builder(
//             itemCount: 604,
//             controller: pageController,
//             onPageChanged: (page) {
//               setState(() {
//                 currentPage = page;
//                 getData(page);
//               });
//             },
//             itemBuilder: (BuildContext context, int index) {
//               if (index == currentPage && data.length != 0) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RichText(
//                     overflow: TextOverflow.visible,
//                     textAlign: TextAlign.justify,
//                     locale: context.locale,
//                     text: TextSpan(
//                         text: '',
//                         recognizer: DoubleTapGestureRecognizer()
//                           ..onDoubleTap = () {
//                             setState(() {});
//                           },
//                         style: const TextStyle(
//                           fontFamily: 'Kitab',
//                           // fontFamily: 'HafsSmart',
//                           color: Colors.black,
//                           fontSize: 24,
//                           // height: 2,
//                           textBaseline: TextBaseline.alphabetic,
//                         ),
//                         children: [
//                           for (int i = 0; i < data.length; i++) ...{
//                             TextSpan(
//                               text: '${data[i]['text']}',
//                             ),
//                             WidgetSpan(
//                               baseline: TextBaseline.alphabetic,
//                               child: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 6, vertical: 8),
//                                 decoration: BoxDecoration(
//                                   image:const  DecorationImage(
//                                     opacity: 0.5,
//                                     image: AssetImage(
//                                       'images/end.png',
//                                     ),
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child:
//                                 Text('${data[i]['numberInSurah']}'),
//                               ),
//                             ),
//                           }
//                         ]),
//                   ),
//                 );
//               }
//               else {
//                 return const  Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:quran_app/screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forqan',
      theme: ThemeData(
        primaryColor: Colors.cyanAccent,
      ),
      home: HomeScreen(),
    );
  }
}
