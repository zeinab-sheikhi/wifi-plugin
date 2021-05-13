
import 'dart:async';

import 'package:flutter/services.dart';

class Wifi {
  static const MethodChannel _channel =
  const MethodChannel('wifi_plugin');

  static Future<Map<dynamic, dynamic>> get accessPoints async{

      Map<dynamic, dynamic> ssidRssiValues = {};
    try{
      ssidRssiValues = await _channel.invokeMethod("getAccessPoints");
    } on PlatformException {
      print('Error in Performing Channel');
    }
    return ssidRssiValues;
  }

  static Future<List<dynamic>> get wifiScanner async {

     List<dynamic> accessPoint = [];
     try{
      accessPoint = await _channel.invokeMethod("getWiFiScanner");
    } on PlatformException {
      print('Error in Performing Channel');
    }
    return accessPoint;
  }

  static void requestNewScan(bool isNewScanEnabled) async {

    try{
      await _channel.invokeMethod("requestNewScan", {"newScan": isNewScanEnabled});
    } on PlatformException {
      print('Error in Performing Channel');
    }
  }

  static void enableWiFi(bool enable) async {

    try{
      await _channel.invokeMethod("enableWifi", {"enable": enable});
    } on PlatformException {
      print('Error in Enabling Wifi!');
    }
  }

}
