import 'package:flutter/material.dart';

import 'package:wifi_plugin/wifi_plugin.dart';
import 'package:location/location.dart';
import 'package:wifi_plugin_example/util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String ssid = '';
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  _requestPermission() async {

    _serviceEnabled = await location.serviceEnabled();
    print(_serviceEnabled);
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
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
                Wifi.requestNewScan(false);
                getAccessPoints();
            },
              child: Text('SCAN'),),
          ],),
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
        if(rssiValues.length >= 8) {
          print("Initial Size: " + rssiValues.length.toString());
          rssiValues = Util().makeList(rssiValues, 7);
          int avg = Util().calculateMean(rssiValues);
          print(rssiValues);
          print(avg);
        }
      });
    });

  }

  void wifiScanner() async {

    List<dynamic> wifiList = await Wifi.wifiScanner;
    setState(() {
      wifiList.forEach((wifi) {
         ssid = wifi['SSID'];
        String bssid = wifi['BSSID'];
        int rssi = int.parse(wifi['RSSI']);
        int freq = int.parse(wifi['frequency']);
        int channel = int.parse(wifi['channel']);
         print(ssid);
      });
    });
  }
}
