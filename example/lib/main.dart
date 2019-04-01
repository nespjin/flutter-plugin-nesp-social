import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_join_qq_group/flutter_plugin_join_qq_group.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _isCalledQQ = false;
  String _callQQMessage = 'no call';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPluginJoinQqGroup.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    bool isCalledQQ;
    String callQQMessage;
    try {
      isCalledQQ = await FlutterPluginJoinQqGroup.joinQQGroup();
    } on PlatformException catch (e) {
      isCalledQQ = false;
      callQQMessage =
          'Exception Code:${e.code}\n'
              'Message:${e.message}\n'
              'Details:${e.details}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _isCalledQQ = isCalledQQ;
      _callQQMessage = callQQMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'
              'isCalledQQ:$_isCalledQQ\n'
              'callQQMessage:$_callQQMessage'),
        ),
      ),
    );
  }
}
