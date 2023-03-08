import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as HtmlDoc;
import 'package:html/parser.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

List texts = [];

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
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
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
    sendRequest("https://codeyad.com/");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("parse html in dart"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView.builder(
            itemCount: texts.length,
            itemBuilder: (context, index) {
              return Directionality(textDirection: TextDirection.rtl,child: Text(texts[index],style: const TextStyle(color: Colors.black),));
            },
        ),
      ),
    );
  }
}

sendRequest(String url) async {
  Client httpClient = Client();
  final response = await httpClient.get(Uri.parse(url));
  if(response.statusCode == 200){
    var doc = parse(response.body);
    doc.getElementsByTagName("p").toList().forEach((element) {
      texts.add(element.text);
    });
    print(doc.getElementsByTagName("p").length);
  }else{
    throw Exception();
  }
}

