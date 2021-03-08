import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(ScannerApp());

class ScannerApp extends StatefulWidget {
  @override
  _ScannerAppState createState() => _ScannerAppState();
}

class _ScannerAppState extends State<ScannerApp> {
  String _scanResult = "";

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanAQRCode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanResult = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanResult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: const Text('Scanners')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () => scanBarcodeNormal(),
                            child: Text(
                              "Click to Scan a Bar Code",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () => scanAQRCode(),
                            child: Text("Click to Scan a QR Code",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        // RaisedButton(
                        //     color: Colors.red,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(18.0),
                        //     ),
                        //     onPressed: () => startBarcodeScanStream(),
                        //     child: Text("Start barcode scan stream",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             color: Colors.white))),
                        // Text("$_scanResult\n", style: TextStyle(fontSize: 20))
                        //
                      ]));
            })));
  }
}
