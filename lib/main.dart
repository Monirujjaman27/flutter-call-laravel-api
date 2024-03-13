import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomepageState createState() => new HomepageState();
}

class HomepageState extends State<HomePage> {
  final String url = "https://fkss.monisoft.xyz/api/fatch-customer";
  List data = [];

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<void> getJsonData() async {
    final res =
        await http.get(Uri.parse(url), headers: {"accept": "application/json"});

    print(res.body);

    setState(() {
      var cnv_json = jsonDecode(res.body);
      data = cnv_json['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Fatch Customer Data"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext contex, int index) {
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
