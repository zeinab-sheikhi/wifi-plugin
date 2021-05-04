import 'dart:io';

import 'package:flutter/material.dart';

import 'package:wifi_plugin/wifi_plugin.dart';
import 'package:location_permissions/location_permissions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  void requestPermissions() async {
    PermissionStatus permission = await LocationPermissions().requestPermissions();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WiFi Scan Plugin'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ElevatedButton(onPressed: () {
              setState(() {
                // wifiScanner();
                Wifi.requestNewScan(false);
                getAccessPoints();
              });
            }, child: Text('SCAN'),),
          ],),
        ),
      ),
    );
  }

  void getAccessPoints() async {

    Map<dynamic, dynamic> accessPoints = await Wifi.accessPoints;
    accessPoints.forEach((key, value) {
      String bssid = key;
      List<int> rssiValues = List.of(value)?.cast<int>();
      print('BSSID: ' + bssid);
    });
  }

  void wifiScanner() async {

    List<dynamic> wifiList = await Wifi.wifiScanner;
    wifiList.forEach((wifi) {
      String ssid = wifi['SSID'];
      String bssid = wifi['BSSID'];
      int rssi = int.parse(wifi['RSSI']);
      int freq = int.parse(wifi['frequency']);
      int channel = int.parse(wifi['channel']);
    });
  }
}
