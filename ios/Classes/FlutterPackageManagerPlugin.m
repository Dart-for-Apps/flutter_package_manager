#import "FlutterPackageManagerPlugin.h"
#import <flutter_package_manager/flutter_package_manager-Swift.h>

@implementation FlutterPackageManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPackageManagerPlugin registerWithRegistrar:registrar];
}
@end
