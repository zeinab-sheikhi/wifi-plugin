
import 'dart:async';

import 'package:flutter/services.dart';

class Wifi {
  static const MethodChannel _channel =
  const MethodChannel('wifi_plugin');

  static Future<Map<dynamic, dynamic>> get accessPoints async{

     late Map<dynamic, dynamic> ssidRssiValues;
    try{
      ssidRssiValues = await _channel.invokeMethod("getAccessPoints");
      return ssidRssiValues;
    } on PlatformException {
      print('Error in Performing Channel');
    }
    return ssidRssiValues;
  }

  static Future<List<dynamic>> get wifiScanner async {

     late var accessPoint;
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

}
