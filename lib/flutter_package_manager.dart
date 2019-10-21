import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterPackageManager {
  static const MethodChannel _channel = const MethodChannel(
      'dev.wurikiji.flutter_package_manager.method_channel', JSONMethodCodec());

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<PackageInfo> getPackageInfo(String name) async {
    Map result = await _channel.invokeMethod('getPackageInfo', <dynamic>[name]);
    return PackageInfo.fromMap(result);
  }
}

class PackageInfo {
  PackageInfo({
    this.packageName,
    this.appName,
    this.appIconByteArray,
  });

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

  Image get appIcon => appIconByteArray != null
      ? Image.memory(base64Decode(appIconByteArray))
      : null;

  static String _eliminateNewLine(String s) => s?.replaceAll('\n', '');

  @override
  String toString() =>
      'Package: $packageName, AppName: $appName, IconByteArray size: ${appIconByteArray?.length}';
}
