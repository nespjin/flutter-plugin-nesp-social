import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNespSocial {

  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_nesp_social');

  static Future<bool> joinQQGroup(
      {String androidKey, String iosKey, String groupUin}) async {
    final bool isSuccess = await _channel.invokeMethod('joinQQGroup', {
      "androidKey": androidKey,
      "iosKey": iosKey,
      "groupUin": groupUin,
    });
    return isSuccess;
  }

  static Future<bool> openWeiboUser({
    String uid,
  }) async {
    final bool isSuccess = await _channel.invokeMethod('openWeiboUser', {
      "uid": uid,
    });
    return isSuccess;
  }

  static Future<bool> joinQQFriend({
    String qqFriendNumber,
  }) async {
    final bool isSuccess = await _channel.invokeMethod('joinQQFriend', {
      "qqFriendNumber": qqFriendNumber,
    });
    return isSuccess;
  }

  static Future<bool> openOtherApp({
    String androidPackageName,
    String androidClassName,
    String iosAppUrl,
  }) async {
    final bool isSuccess = await _channel.invokeMethod('openOtherApp', {
      "androidPackageName": androidPackageName,
      "androidClassName": androidClassName,
      "iosAppUrl": iosAppUrl,
    });
    return isSuccess;
  }
}
