import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/package_info.dart';
export 'src/package_info.dart';

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

  /// Get the `List<String>` of the ***user installed*** applications.
  /// This includes the system apps.
  /// You can use this name as a parameter of `getPackageInfo()` call.
  static Future<List> getUserInstalledPackages() async {
    return await _channel.invokeMethod('getUserInstalledPackages');
  }

  /// Get the information about an apk file stored on your local Storage.
  /// Pass the path of the apk file like `getPackageInfoByApkFile('/storage/emulated/0/xyz.apk')`.
  /// And you can get the `PackageName`, `AppName`, And `ApplicationIcon`
  static Future<PackageInfo> getPackageInfoByApkFile(String path) async {
    Map result =
        await _channel.invokeMethod('getPackageInfoByApkFile', <dynamic>[path]);
    return PackageInfo.fromMap(result);
  }
}
