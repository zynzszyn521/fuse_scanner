# fuse_scanner

## 支持的PDA品牌
### HONEYWELL(霍尼韦尔)--com.honeywell.decode.intent.action.EDIT_DATA
### HONEYWELL(霍尼韦尔)--com.ehsy.warehouse.action.BARCODE_DATA
### IDATA--android.intent.action.SCANRESULT
### ZEBRA(斑马)--com.symbol.datawedge.action.DATA_STRING


 ```
 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuse_scanner/fuse_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription<String> _scanResultSubscription;
  String scanValue = '';

  @override
  void initState() {
    _listenPda();
    super.initState();
  }

  @override
  void dispose() {
    _scanResultSubscription.cancel();
    super.dispose();
  }

  Future _listenPda() async {
    try {
      _scanResultSubscription = FuseScanner.onScanResult.listen((scanResult) {
        setState(() {
          scanValue = scanResult;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(scanValue),
      ),
    );
  }
}

```