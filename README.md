# Package Manager for Android

This plugin offers the ability of android's `PackageManager`.
You can retrieve the `app name`, `app launcher icon` through
this package with its `package name`. The package should be
installed on a device.

This plugin supports android only and it is based on `androidx`.

# How to use

See the `./example` and `./lib` folders for the details.

## Modify minSdkVersion of the android gradle

In the `android/app` folder open the `build.gradle` file and edit `minSdkVersion`
to greater than or equal to 22.

## Get package information from the package name

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
If the app is not installed, than `null` is returned.

## Get package names of the all applications installed on the device

```dart
import 'package:flutter_package_manager/flutter_package_manager.dart';

/// ... other codes

Future<List> getInstalledPackages() async {
  // All apps including system apps
  List packages = await FlutterPackageManager.getInstalledPackages();

  // Apps installed by user
  List userInstalledPackages = await FlutterPackageManager.getUserInstalledPackages();
  return packages;
}
```
