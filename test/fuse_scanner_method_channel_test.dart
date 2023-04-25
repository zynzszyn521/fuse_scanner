import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuse_scanner/fuse_scanner_method_channel.dart';

void main() {
  MethodChannelFuseScanner platform = MethodChannelFuseScanner();
  const MethodChannel channel = MethodChannel('fuse_scanner');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
