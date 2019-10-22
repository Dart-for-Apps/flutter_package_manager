import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The reflection of PackageManager on Android
class FlutterPackageManager {
  /// Method channel
  static const MethodChannel _channel = const MethodChannel(
      'dev.wurikiji.flutter_package_manager.method_channel', JSONMethodCodec());

  /// Get platform version of the device
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Get package information of the `name` package
  /// Return: `PackageInfo` class
  static Future<PackageInfo> getPackageInfo(String name) async {
    Map result = await _channel.invokeMethod('getPackageInfo', <dynamic>[name]);
    return PackageInfo.fromMap(result);
  }

  /// Get the `List<String>` of the installed applications.
  /// This includes the system apps.
  /// You can use this name as a parameter of `getPackageInfo()` call.
  static Future<List> getInstalledPackages() async {
    return await _channel.invokeMethod('getInstalledPackages');
  }
}

/// The class for package information.
/// Contains package name (e.g., com.facebook.katana), app name (e.g., Facebook), and app icon
class PackageInfo {
  PackageInfo({
    this.packageName,
    this.appName,
    this.appIconByteArray,
  });

  /// Construct class from the json map
  factory PackageInfo.fromMap(Map map) => map == null
      ? null
      : PackageInfo(
          packageName: map['packageName'],
          appIconByteArray: _eliminateNewLine(map['appIcon']),
          appName: map['appName'],
        );

  final String packageName;
  final String appName;
  final String appIconByteArray;

  /// Get flutter's `Image` widget from the byte array of app icon
  Image get appIcon => appIconByteArray != null
      ? Image.memory(base64Decode(appIconByteArray))
      : null;

  @override
  String toString() =>
      'Package: $packageName, AppName: $appName, IconByteArray size: ${appIconByteArray?.length}';
}

/// helper function
String _eliminateNewLine(String s) => s?.replaceAll('\n', '');
