import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPackageManager {
  static const MethodChannel _channel =
      const MethodChannel('flutter_package_manager');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
