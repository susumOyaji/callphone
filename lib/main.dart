import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
//import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _numberCtrl = new TextEditingController();
  TelephonyInfo _info;
  CallState _callState = new CallState();

  int count = 0;
  DateTime now = DateTime.now();
  String currentmonth = DateFormat('\n EEE d MMM\n').format(DateTime
      .now()); //DateFormat('kk:mm:ss \n EEE d MMM').format(now);//DateTime.now().month.toString();

  @override
  void initState() {
    super.initState();
    getTelephonyInfo();

    Timer.periodic(const Duration(seconds: 10), _timer);
    _numberCtrl.text = "085921191121";
  }

  void _timer(Timer timer) {
    count++;
    print('$count');
    //getTelephonyInfo();
    //print(_info);
    //reload();
  }

  void reload() async {
    print(currentmonth);

    getTelephonyInfo();
    print(_info);
    //reload1();
    //base();
  }

  Future<void> getTelephonyInfo() async {
    TelephonyInfo info;
    try {
      info = await FltTelephonyInfo.info;
    } on PlatformException {}

    if (!mounted) return;

    setState(() {
      _info = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Column(children: <Widget>[
          Text(
              'getTelePhoneInfo: ${_info.callState.toString() /*line1Number*/}\n'), //////
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _numberCtrl,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            child: Text("Start Call"),
            onPressed: () async {
              FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
            },
          ),
          ElevatedButton(
            child: Text("Rpeet Call"),
            onPressed: () async {
              FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
            },
          )
        ]),
      ),
    );
  }
}
