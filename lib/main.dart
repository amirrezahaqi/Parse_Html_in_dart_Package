import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as HtmlDoc;
import 'package:html/parser.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

List texts = [];
List tit = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //

        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    sendRequest(
        "https://dehghanifard.ir/%d8%a2%d9%85%d9%88%d8%b2%d8%b4-%d8%a8%d8%b1%d9%86%d8%a7%d9%85%d9%87-%d9%86%d9%88%db%8c%d8%b3%db%8c-%d8%ba%db%8c%d8%b1-%d9%87%d9%85%d8%b2%d9%85%d8%a7%d9%86-%d8%af%d8%b1-%d8%b2%d8%a8%d8%a7%d9%86-%d8%af/");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            tit.toString(),
            style: const TextStyle(
                fontFamily: "Peyda", fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    texts[index],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Peyda",
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  sendRequest(String url) async {
    Client httpClient = Client();
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      doc.getElementsByTagName("p").toList().forEach((element) {
        if (doc.getElementsByTagName("p").length > 20) {
          texts.add(element.text);
        }

        setState(() {});
      });

      doc.getElementsByTagName("h1").toList().forEach(
        (element) {
          tit.add(element.text);
        },
      );

      print(doc.getElementsByTagName("p").length);
    } else {
      throw Exception();
    }
  }
}
