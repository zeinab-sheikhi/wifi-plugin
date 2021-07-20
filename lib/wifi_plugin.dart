
import 'dart:async';

import 'package:flutter/services.dart';

class Wifi {
  static const MethodChannel _channel =
  const MethodChannel('wifi_plugin');

  static Future<Map<dynamic, dynamic>>  getAccessPoints(int index) async{
      Map<dynamic, dynamic> ssidRssiValues = {};
    try{
      ssidRssiValues = await _channel.invokeMethod("getAccessPoints", {"index": index});
    } on PlatformException {
      print('Error in Performing Channel');
    }
    return ssidRssiValues;
  }

  static void setRssiListSize(int size) async {
    try{
      await _channel.invokeMethod("setRssiListSize", {"size": size});
    } on PlatformException {
      print('Error in Performing Channel');
    }
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

  static void enableWiFi(bool isEnabled) async {
    try{
      await _channel.invokeMethod("enableWifi", {"isEnabled": isEnabled});
    } on PlatformException {
      print('Error in Enabling Wifi!');
    }
  }

  static Future<bool> get isWiFiEnable async{
    bool isEnable = false;
    try{
      isEnable = await _channel.invokeMethod("isWifiEnable");
    } on PlatformException {
      print('Error in Performing Channel');
    }
    return isEnable;
  }

}
