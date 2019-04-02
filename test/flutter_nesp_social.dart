import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_nesp_social/flutter_nesp_social.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_plugin_join_qq_group');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

//  test('getPlatformVersion', () async {
//    expect(await FlutterNespSocial.platformVersion, '42');
//  });
}
