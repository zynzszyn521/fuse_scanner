import 'fuse_scanner_platform_interface.dart';

abstract class FuseScanner {
  static Future<String?> getPlatformVersion() {
    return FuseScannerPlatform.instance.getPlatformVersion();
  }

  static Future<String?> startScan() async {
    return await FuseScannerPlatform.instance.startScan();
  }

  static Future<void> stopScan() async {
    await FuseScannerPlatform.instance.stopScan();
  }

  static Stream<String> get onScanResult {
    return FuseScannerPlatform.instance.onScanResult;
  }
}
