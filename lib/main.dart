import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flt_telephony_info/flt_telephony_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyApp1(title: 'app-to-phone-flutter'),
    );
  }
}

class MyApp1 extends StatefulWidget {
  MyApp1({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  SdkState _sdkState = SdkState.LOGGED_OUT;
  TextEditingController textEditingController = new TextEditingController();
  TelephonyInfo _info;
  int count = 0;
  DateTime now = DateTime.now();
  String currentmonth = DateFormat('\n EEE d MMM\n').format(DateTime
      .now()); //DateFormat('kk:mm:ss \n EEE d MMM').format(now);//DateTime.now().month.toString();

  @override
  void initState() {
    super.initState();
    //getDeviceInfo();
    //getTelephonyInfo();

    Timer.periodic(const Duration(seconds: 10), _timer);
    textEditingController.text = "085921191121";
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

  /*
  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(_readAndroidBuildData(androidInfo).toString());
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(_readIosDeviceInfo(iosInfo).toString());
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[SizedBox(height: 64), _updateView()],
        ),
<<<<<<< HEAD
        body: new Column(children: <Widget>[
          Text('getTelePhone Number: ${_info?.line1Number}\n'), //////
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
=======
>>>>>>> 43ec3d8265b59bfe913c8c66f6f960fe646985fe
      ),
    );
  }

  Widget _updateView() {
    if (_sdkState == SdkState.LOGGED_OUT) {
      return RaisedButton(child: Text("LOGIN AS ALICE"));
    }
  }

  Future<void> _loginUser() async {
    String token = "ALICE_TOKEN";

    try {
      await platformMethodChannel
          .invokeMethod('loginUser', <String, dynamic>{'token': token});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _makeCall() async {
    // Make call
  }

  Future<void> _endCall() async {
    // End call
  }

  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

enum SdkState { LOGGED_OUT, LOGGED_IN, WAIT, ON_CALL, ERROR }
