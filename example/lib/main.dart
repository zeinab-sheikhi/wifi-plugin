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

  bool _isEnable = false;
  int index = 0;
  int size = 20;

  @override
  void initState() {
    super.initState();
    isWifiEnable();
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
              child: Text('Scan'),
              onPressed: () {
                getAccessPoints(index);
                setState(() {
                  index = index + 1;
                });
            },
            ),
          ],
          ),
        ),
      ),
    );
  }

  void getAccessPoints(int index) async {
    Map<dynamic, dynamic> accessPoints = await Wifi.getAccessPoints(index);
    accessPoints.forEach((key, value) {
      print(key);
      print(value);
    });
  }

  void setRssiListSize() async {
    Wifi.setRssiListSize(size);
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

  void isWifiEnable() async{
    bool result = await Wifi.isWiFiEnable;
    setState(() {
      _isEnable = result;
    });
  }
}
