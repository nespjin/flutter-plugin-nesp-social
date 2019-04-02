import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_nesp_social/flutter_plugin_nesp_social.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //QQ好友号码
  final String qqFriendNumber = "2021785540";

  //QQ群Android平台Key
  String qqGroupAndroidKey;

  //QQ群号码
  final String qqGroupUin = '428741525';

  //QQ群IOS平台Key
  String qqGroupIosKey;

  //微博UID
  final String weiboUid = "3619635672";

  //其他应用的包名
  final String otherAppAndroidPkgName = "com.nesp.movie";

  //其他应用的Activity类名
  final String otherAppAndroidClsName =
      "com.nesp.movie.ui.activity.WelcomeActivity";

  bool _isCalledApp = false;
  String _callAppMessage = 'not called app';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nesp Social example'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'isCalledApp:$_isCalledApp\n\n'
                    'callAppMessage:\n$_callAppMessage',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NespButton(
                    text: "加好友\n$qqFriendNumber",
                    onPressed: joinQQFriend,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: NespButton(
                      text: "加群\n$qqGroupUin",
                      onPressed: () {
                        qqGroupAndroidKey = '3EGJ3WZQ5xBG1Ii8hUh3nJSZpYxQp_kn';
                        qqGroupIosKey =
                            '045e027a8781a7b6f0a8b60d03c7d9f7ff079047f0dc5e5624bbf73e181a19b9';
                        joinQQGroup();
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: NespButton(
                        text: "Join QQ group\nwithout key",
                        onPressed: () {
                          qqGroupAndroidKey = null;
                          qqGroupIosKey = null;
                          joinQQGroup();
                        },
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NespButton(
                  text: "打开微博用户",
                  onPressed: openWeiboUser,
                ),
              ],
            ),
         Padding(
           padding: EdgeInsets.only(top: 20),
           child:    Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               NespButton(
                 text: "打开其他应用\n$otherAppAndroidPkgName",
                 onPressed: openOtherApp,
               ),
             ],
           ),
         ),
          ],
        )),
      ),
    );
  }

  void openWeiboUser() {
    bool isCalledWeibo;
    String callWeiboMessage;
    try {
      FlutterNespSocial.openWeiboUser(
        uid: weiboUid,
      ).then((isSuccess) {
        isCalledWeibo = isSuccess;
        callWeiboMessage = "weiboUid:$weiboUid";
        if (!mounted) return;
        setState(() {
          _isCalledApp = isCalledWeibo;
          _callAppMessage = callWeiboMessage;
        });
      });
    } on PlatformException catch (e) {
      isCalledWeibo = false;
      callWeiboMessage = 'Exception When Call weibo\n'
          'Code:${e.code}\n'
          'Message:${e.message}\n'
          'Details:${e.details}';
    }
  }

  Future<void> joinQQFriend() async {
    bool isCalledQQ;
    String callQQMessage;

    try {
      isCalledQQ = await FlutterNespSocial.joinQQFriend(
        qqFriendNumber: qqFriendNumber,
      );
      callQQMessage = 'qqFriendNumber: $qqFriendNumber';
    } on PlatformException catch (e) {
      isCalledQQ = false;
      callQQMessage = 'Exception When Join QQ Friend\n'
          'Code:${e.code}\n'
          'Message:${e.message}\n'
          'Details:${e.details}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isCalledApp = isCalledQQ;
      _callAppMessage = callQQMessage;
    });
  }

  Future<void> joinQQGroup() async {
    bool isCalledQQ;
    String callQQMessage;

    try {
      isCalledQQ = await FlutterNespSocial.joinQQGroup(
        androidKey: qqGroupAndroidKey,
        groupUin: qqGroupUin,
        iosKey: qqGroupIosKey,
      );

      callQQMessage = 'qqGroupAndroidKey: $qqGroupAndroidKey'
          'qqGroupUin:$qqGroupUin'
          'qqGroupIosKey:$qqGroupIosKey ';
    } on PlatformException catch (e) {
      isCalledQQ = false;
      callQQMessage = 'Exception When Join QQ Group\n'
          'Code:${e.code}\n'
          'Message:${e.message}\n'
          'Details:${e.details}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isCalledApp = isCalledQQ;
      _callAppMessage = callQQMessage;
    });
  }

  Future<void> openOtherApp() async {
    bool isCalledOtherApp;
    String callOtherAppMessage;

    try {
      isCalledOtherApp = await FlutterNespSocial.openOtherApp(
        androidPackageName: otherAppAndroidPkgName,
        androidClassName: otherAppAndroidClsName,
        iosAppUrl: "",
      );

      callOtherAppMessage = 'androidPackageName: $otherAppAndroidPkgName\n'
          'androidClassName:$otherAppAndroidClsName';
    } on PlatformException catch (e) {
      isCalledOtherApp = false;
      callOtherAppMessage = 'Exception When Call Other APP\n'
          'Code:${e.code}\n'
          'Message:${e.message}\n'
          'Details:${e.details}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isCalledApp = isCalledOtherApp;
      _callAppMessage = callOtherAppMessage;
    });
  }
}

class NespButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  NespButton({@required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
        child: Text(text),
        elevation: 2,
        height: 50,
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: onPressed);
  }
}
