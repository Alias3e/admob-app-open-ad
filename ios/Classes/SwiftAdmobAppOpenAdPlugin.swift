import Flutter
import UIKit

public class SwiftAdmobAppOpenAdPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "admob_app_open_ad", binaryMessenger: registrar.messenger())
    let instance = SwiftAdmobAppOpenAdPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
