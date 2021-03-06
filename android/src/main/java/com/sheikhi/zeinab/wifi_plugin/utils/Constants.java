package com.sheikhi.zeinab.wifi_plugin.utils;

public class Constants {

    public static boolean enableNewScan = false;
    public static int rssiListSize = 20;

    public static final String GET_ACCESS_POINTS_CHANNEL = "getAccessPoints";
    public static final String SET_SIZE = "setRssiListSize";
    public static final String GET_WIFI_SCANNER_CHANNEL = "getWiFiScanner";
    public static final String REQUEST_NEW_SCAN_CHANNEL = "requestNewScan";
    public static final String ENABLE_WIFI_CHANNEL = "enableWifi";
    public static final String IS_WIFI_ENABLE_CHANNEL = "isWifiEnable";
    public static final String CHANNEL_NAME = "wifi_plugin";
    public static final String CHANNEL_ARGUMENT_NEW_SCAN_KEY = "newScan";
    public static final String CHANNEL_ARGUMENT_WIFI_ENABLE_KEY = "isEnabled";
    public static final String CHANNEL_ARGUMENT_RSSIs_SIZE = "size";

    // HashMap keys
    public static final String BSSID = "BSSID";
    public static final String SSID = "SSID";
    public static final String RSSI = "RSSI";
    public static final String FREQUENCY = "frequency";
    public static final String CHANNEL = "channel";

    public static final String TAG = "WiFi Flutter Plugin";

}
