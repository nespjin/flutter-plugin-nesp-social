import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginJoinQqGroup {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_join_qq_group');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
