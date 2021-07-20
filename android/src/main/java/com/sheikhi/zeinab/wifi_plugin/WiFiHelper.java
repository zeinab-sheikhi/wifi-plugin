package com.sheikhi.zeinab.wifi_plugin;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;

import com.sheikhi.zeinab.wifi_plugin.utils.Constants;
import com.sheikhi.zeinab.wifi_plugin.utils.Util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WiFiHelper {
    private final WifiManager wifiManager;
    private final Context context;
    private List<ScanResult> scanResults;
    private HashMap<String, int[]> bssidRssiMap = new HashMap<>();

    public WiFiHelper(WifiManager wifiManager, Context context) {
        this.context = context;
        this.wifiManager = wifiManager;
        context.registerReceiver(wifiScanReceiver, new
                IntentFilter(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION));
        wifiManager.startScan();
    }

    public HashMap<String, int[]> getAccessPoints(int index) {
        //if new scan is requested, clear previous result.
        if (Constants.enableNewScan)
            bssidRssiMap.clear();
        wifiManager.startScan();
        for (ScanResult accessPoint : scanResults)
            getAccessPointSpecs(accessPoint, index);
        return bssidRssiMap;
    }

    /**
     Return access point BSSID(MAC Address) and RSSI(level) as a HashMap in which 
     key is access point's mac address and value is list of access point's rssi values.
     **/
    private void getAccessPointSpecs(ScanResult scanResult, int index) {
        String bssid = scanResult.BSSID;
        int rssi = scanResult.level;
        int[] rssiList = new int[Constants.rssiListSize];

        if(!bssidRssiMap.containsKey(bssid))
            Arrays.fill(rssiList, -100);
        else
            rssiList = bssidRssiMap.get(bssid);
        
        assert rssiList!= null;
        rssiList[index] = rssi;
        bssidRssiMap.put(bssid, rssiList);
    }
    
    /**
     Return an array of access points in which each access point is a Map. 
     values are access point's SSID, BSSID, RSSI, frequency, channel.
     **/
    public ArrayList<Map<String, String>> wifiScanner() {
        ArrayList<Map<String, String>> accessPointList = new ArrayList<>();
        wifiManager.startScan();
        for (ScanResult result : scanResults) {
            HashMap<String, String> accessPointMap = Util.createAccessPointMap(result);
            accessPointList.add(accessPointMap);
        }
        return accessPointList;
    }
    
    /**
     Enable or Disable WiFi based on the input
     **/
    public void enableWiFi(boolean enable) {
        wifiManager.setWifiEnabled(enable);
    }
    
    public boolean isWiFiEnable() {return wifiManager.isWifiEnabled();}

    BroadcastReceiver wifiScanReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            scanResults = wifiManager.getScanResults();
        }
    };
}

