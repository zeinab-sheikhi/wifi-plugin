package com.sheikhi.zeinab.wifi_plugin;

import android.content.Context;
import android.net.wifi.WifiManager;
import android.provider.SyncStateContract;

import androidx.annotation.NonNull;

import com.sheikhi.zeinab.wifi_plugin.utils.Constants;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** WifiPlugin */
public class WifiPlugin implements FlutterPlugin {
  private MethodChannel channel;
  private Context context;


  public WifiPlugin() {

  }

  @SuppressWarnings("deprecation")
  public static void registerWith(Registrar registrar) {
    final WifiPlugin instance = new WifiPlugin();
    instance.setUpChannel(registrar.context(), registrar.messenger());
  }



  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
    setUpChannel(context, messenger);
  }

  public void setUpChannel(Context context, BinaryMessenger messenger) {
    WifiManager wifiManager = (WifiManager)
            context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
    WiFiHelper wiFiHelper = new WiFiHelper(wifiManager, context);
    channel = new MethodChannel(messenger, Constants.CHANNEL_NAME);
    WiFiMethodChannelHandler wiFiMethodChannelHandler = new WiFiMethodChannelHandler(wiFiHelper);
    channel.setMethodCallHandler(wiFiMethodChannelHandler);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    channel = null;
    context = null;
  }
}
