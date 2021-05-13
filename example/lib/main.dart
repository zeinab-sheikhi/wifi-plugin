import 'package:flutter/material.dart';

import 'package:wifi_plugin/wifi_plugin.dart';

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
            ElevatedButton(
              onPressed: () {
                _enableWiFi();
            },
              child: Text('Enable'),
            ),
              ElevatedButton(
                onPressed: () {
                  _disableWifi();
                },
                child: Text('Disable'),
              ),
          ],
          ),
        ),
      ),
    );
  }

  void getAccessPoints() async {

    Map<dynamic, dynamic> accessPoints = await Wifi.accessPoints;
    setState(() {
      accessPoints.forEach((key, value) {
        String bssid = key;
        List<int> rssiValues = List.of(value)?.cast<int>();
        print(rssiValues);
      });
    });

  }

  void wifiScanner() async {

    List<dynamic> wifiList = await Wifi.wifiScanner;
    setState(() {
      wifiList.forEach((wifi) {
        String ssid = wifi['SSID'];
        String bssid = wifi['BSSID'];
        int rssi = int.parse(wifi['RSSI']);
        int freq = int.parse(wifi['frequency']);
        int channel = int.parse(wifi['channel']);
      });
    });
  }

  void _enableWiFi() {
    Wifi.enableWiFi(true);
  }
  void _disableWifi() {
    Wifi.enableWiFi(false);
  }
}
