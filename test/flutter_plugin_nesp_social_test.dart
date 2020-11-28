import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_plugin_nesp_social/flutter_plugin_nesp_social.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_plugin_nesp_social');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await FlutterNespSocial.platformVersion, '42');
  // });
}
