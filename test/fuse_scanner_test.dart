import 'package:flutter_test/flutter_test.dart';
import 'package:fuse_scanner/fuse_scanner.dart';
import 'package:fuse_scanner/fuse_scanner_platform_interface.dart';
import 'package:fuse_scanner/fuse_scanner_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFuseScannerPlatform
    with MockPlatformInterfaceMixin
    implements FuseScannerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FuseScannerPlatform initialPlatform = FuseScannerPlatform.instance;

  test('$MethodChannelFuseScanner is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFuseScanner>());
  });

  test('getPlatformVersion', () async {
    FuseScanner fuseScannerPlugin = FuseScanner();
    MockFuseScannerPlatform fakePlatform = MockFuseScannerPlatform();
    FuseScannerPlatform.instance = fakePlatform;

    expect(await fuseScannerPlugin.getPlatformVersion(), '42');
  });
}
