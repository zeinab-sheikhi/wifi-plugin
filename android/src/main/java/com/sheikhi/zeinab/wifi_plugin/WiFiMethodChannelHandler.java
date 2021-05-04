package com.sheikhi.zeinab.wifi_plugin;

import androidx.annotation.NonNull;

import com.sheikhi.zeinab.wifi_plugin.utils.Constants;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class WiFiMethodChannelHandler implements MethodChannel.MethodCallHandler {

    private final WiFiHelper wifiHelper;

    public WiFiMethodChannelHandler(WiFiHelper wifiHelper) {
        this.wifiHelper = wifiHelper;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case Constants.GET_ACCESS_POINTS_CHANNEL:
                result.success(wifiHelper.getAccessPoints());
                break;
            case Constants.REQUEST_NEW_SCAN_CHANNEL:
                Constants.enableNewScan = call.argument(Constants.CHANNEL_ARGUMENT_KEYWORD);
                break;
            case Constants.GET_WIFI_SCANNER_CHANNEL:
                result.success(wifiHelper.wifiScanner());
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
