import Flutter
import UIKit

public class SwiftFlutterPluginJoinQqGroupPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_nesp_social", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginJoinQqGroupPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   
    if (call.method.compare("getPlatformVersion").rawValue==0) {
        result("iOS " + UIDevice.current.systemVersion)
    }else if(call.method.compare("joinQQGroup").rawValue==0){
        
        let args
            = call.arguments as! Dictionary<String,NSObject>
        
        let groupUin = args["groupUin"]!
        
        if((groupUin as? String)!.compare("").rawValue==0){
            result(FlutterError.init(code: "GroupUin is Empty", message: "are you set groupUin on Flutter?", details: groupUin))
            return
        }
        let key = args["iosKey"]
        if((key as? String)!.compare("").rawValue==0){
            result(FlutterError.init(code: "iosKey is Empty", message: "are you set iosKey on Flutter?", details: key))
            return
        }
        
           if (joinQQGroup(groupUin: groupUin as! NSString, iosKey: key as! NSString)) {
                result("")
            }else{
                result(FlutterError.init(code: "NOT INSTALL IOS QQ", message: "are you install ios QQ?", details: key))
            }
      
        
    }
    
  }
    
    private func joinQQGroup(groupUin:NSString,iosKey:NSString) -> Bool {
        let urlStr = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=\(groupUin)&key=\(iosKey)&card_type=group&source=external"
        let url = URL.init(string: urlStr)
        if(url==nil){
            return false
        }
        if(UIApplication().canOpenURL(url!)){
            UIApplication().openURL(url!)
            return true;
        }else{
            return false
        }
    }

}
