#import "AdmobAppOpenAdPlugin.h"
#if __has_include(<admob_app_open_ad/admob_app_open_ad-Swift.h>)
#import <admob_app_open_ad/admob_app_open_ad-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "admob_app_open_ad-Swift.h"
#endif

@implementation AdmobAppOpenAdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdmobAppOpenAdPlugin registerWithRegistrar:registrar];
}
@end
