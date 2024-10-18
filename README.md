# WiFi Plugin for Flutter

A custom Flutter plugin for accessing WiFi information on Android devices using platform-specific code in Java. This plugin uses Flutter's platform channels to communicate with the underlying Android WiFi APIs, enabling your Flutter application to interact with WiFi functionalities directly.

## Features

This plugin provides the following WiFi data and functionalities:
- **WiFi Scanning**: Get a list of nearby WiFi access points, including details like SSID, BSSID (MAC Address), RSSI (signal strength), frequency, and channel.
- **Enable/Disable WiFi**: Programmatically enable or disable WiFi on the device.
- **Check WiFi Status**: Check if WiFi is currently enabled or disabled on the device.
- **Retrieve RSSI Values**: Access the RSSI levels of WiFi networks and track their changes over time.

## Platform-Specific Implementation

- The plugin is implemented using Java for the Android platform.
- Flutter platform channels are utilized to communicate between the Flutter app and the native Android code.
- A `WiFiHelper` class is used to manage WiFi scanning and control functionalities.
- The plugin registers a BroadcastReceiver to listen for WiFi scan results and updates the list of nearby access points.

## Installation

To use this plugin, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  wifi_plugin:
    git:
      url: https://github.com/zeinab-sheikhi/wifi-plugin
```

Then, run `flutter pub get` to install the plugin.

## Usage

Import the package in your Dart file:

```dart
import 'package:wifi_plugin/wifi_plugin.dart';
```

### Example

Here is a basic example of how to use the plugin:

```dart
// Enable WiFi
await WiFiPlugin.enableWiFi(true);

// Check if WiFi is enabled
bool isEnabled = await WiFiPlugin.isWiFiEnable();

// Scan for WiFi access points
List<Map<String, String>> accessPoints = await WiFiPlugin.wifiScanner();

// Print the details of nearby access points
accessPoints.forEach((accessPoint) {
  print('SSID: ${accessPoint['SSID']}');
  print('BSSID: ${accessPoint['BSSID']}');
  print('RSSI: ${accessPoint['RSSI']}');
  print('Frequency: ${accessPoint['frequency']}');
  print('Channel: ${accessPoint['channel']}');
});
```

## Challenges

- **Platform-Specific Code**: Writing platform-specific code for Android required a deep understanding of Java and the Android WiFi API.
- **Asynchronous Communication**: Managing asynchronous communication between Dart and native Java code using method channels presented challenges, especially with handling real-time updates like WiFi scan results.
- **Permission Management**: Ensuring the app has the necessary permissions to access WiFi data and perform scans is crucial, as missing permissions can cause runtime errors.

## Results

- The plugin successfully retrieves detailed WiFi information such as SSID, BSSID, RSSI, and frequency from nearby access points.
- It allows enabling/disabling WiFi directly from a Flutter app, offering seamless integration of WiFi functionalities.
- The RSSI values tracked over time provide insights into signal strength fluctuations, useful for applications like indoor positioning and WiFi-based navigation.
