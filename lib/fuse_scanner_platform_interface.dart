import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fuse_scanner_method_channel.dart';

abstract class FuseScannerPlatform extends PlatformInterface {
  FuseScannerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FuseScannerPlatform _instance = MethodChannelFuseScanner();

  static FuseScannerPlatform get instance => _instance;

  static set instance(FuseScannerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> startScan() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> stopScan() {
    throw UnimplementedError('stopScan() has not been implemented.');
  }

  Stream<String> get onScanResult {
    throw UnimplementedError('onScanResult has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
