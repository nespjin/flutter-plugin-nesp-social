import Flutter
import UIKit

public class SwiftFlutterPluginJoinQqGroupPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_join_qq_group", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginJoinQqGroupPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
