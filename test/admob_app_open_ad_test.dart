import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('admob_app_open_ad');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  // tearDown(() {
  //   channel.setMockMethodCallHandler(null);
  // });
  //
  // test('getPlatformVersion', () async {
  //   expect(await AdmobAppOpenAd.platformVersion, '42');
  // });
}
