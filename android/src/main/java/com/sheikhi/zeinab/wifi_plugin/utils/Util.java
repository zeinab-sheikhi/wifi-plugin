package com.sheikhi.zeinab.wifi_plugin.utils;

import android.net.wifi.ScanResult;

import java.util.HashMap;

public class Util {

    /**
     This method converts frequency in MHz to channel number based on IEEE 802.11 standard.
     **/
    public static int frequencyToChannel(int freq) {
        if (freq == 2484)
            return 14;

        if (freq < 2484)
            return (freq - 2407) / 5;

        return freq/5 - 1000;
    }

    /**
     This method creates a map of an access point specs.  
     **/

    public static HashMap<String, String> createAccessPointMap(ScanResult accessPoint) {

        HashMap<String, String> accessPointMap = new HashMap<>();
        String ssid = accessPoint.SSID;
        if(ssid.equals(""))
            ssid = "Hidden SSID";
        String bssid = accessPoint.BSSID;
        int level = accessPoint.level;
        int frequency = accessPoint.frequency;
        int channel = Util.frequencyToChannel(frequency);

        accessPointMap.put(Constants.SSID, ssid);
        accessPointMap.put(Constants.BSSID, bssid);
        accessPointMap.put(Constants.RSSI, Integer.toString(level));
        accessPointMap.put(Constants.FREQUENCY, Integer.toString(frequency));
        accessPointMap.put(Constants.CHANNEL, Integer.toString(channel));
        return accessPointMap;
    }

}
