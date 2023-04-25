import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fuse_scanner_platform_interface.dart';

class MethodChannelFuseScanner extends FuseScannerPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('com.fuse.scanner/methods');

  StreamSubscription<String>? _scanResultSubscription;
  final StreamController<String> _scanResultStreamController =
      StreamController<String>.broadcast();

  MethodChannelFuseScanner() {
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  @override
  Future<String?> startScan() async {
    try {
      final String result = await methodChannel.invokeMethod('startScan');
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to scan barcode: ${e.message}");
      }
      return "";
    }
  }

  @override
  Future<void> stopScan() async {
    try {
      await methodChannel.invokeMethod<void>('stopScan');
      _scanResultSubscription?.cancel();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to stop scan: ${e.message}");
      }
    }
  }

  @override
  Stream<String> get onScanResult => _scanResultStreamController.stream;

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onScanResult':
        _scanResultStreamController.add(call.arguments as String);
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'The fuse_scanner plugin for platform "${Platform.operatingSystem}" does not implement the method "${call.method}"',
        );
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
