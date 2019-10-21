#  Package Manager for Android

This plugin offers the ability of android's `PackageManager`.
You can retrieve the `app name`, `app launcher icon` through
this package with its `package name`. The package should be
installed on a device. 

This plugin supports android only. 

# How to use

```dart
import 'package:flutter_package_manager/flutter_package_manager.dart';

/// ... other codes 

Future<PackageInfo> getPackageInfo() async {
  final PackageInfo info = 
    await FlutterPackageManager.getPackageInfo('com.facebook.katana');
  return info;
}
```

`PackageInfo` class contains `packageName`, `appName` and `appIconByteArray`.
`appIconByteArray` is an array of `base64` byte image of app icon.
You can get flutter's `Image` widget icon by `appIcon` getter. 

See the `./example` folder for the details. 
