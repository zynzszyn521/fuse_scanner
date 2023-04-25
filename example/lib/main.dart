import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fuse_scanner/fuse_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _scanResult = '';
  late StreamSubscription<String> _scanResultSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    _scanResultSubscription = FuseScanner.onScanResult.listen((scanResult) {
      setState(() {
        _scanResult = scanResult;
      });
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await FuseScanner.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            Text('Scan Data: $_scanResult\n'),
            IconButton(
                onPressed: () {
                  _startScan();
                },
                icon: const Icon(Icons.print)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scanResultSubscription.cancel();
    super.dispose();
  }

  void _startScan() async {
    try {
      String? aa = await FuseScanner.startScan();
      print("手動執行掃碼結果：" + aa!);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
