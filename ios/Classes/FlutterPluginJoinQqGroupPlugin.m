#import "FlutterPluginJoinQqGroupPlugin.h"
#import <UIKit/UIKit.h>
#import <flutter_plugin_join_qq_group/flutter_plugin_join_qq_group-Swift.h>

@implementation FlutterPluginJoinQqGroupPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_plugin_join_qq_group"
                                     binaryMessenger:[registrar messenger]];
    FlutterPluginJoinQqGroupPlugin* instance = [[FlutterPluginJoinQqGroupPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if([@"joinQQGroup" isEqualToString:call.method]){
        NSString *groupUin = call.arguments[@"groupUin"];
        NSString *key = call.arguments[@"iosKey"];
        
        NSLog(@"key is %@",key);

        if(groupUin==Nil||[groupUin isEqualToString:@""]){
            result([FlutterError errorWithCode:@"GroupUin is Empty" message:@"are you set groupUin on Flutter?" details:groupUin]);
            return;
        }

        if(key==nil||[key isEqualToString:@""]){
            result([FlutterError errorWithCode:@"Key is Empty" message:@"are you set iosKey on Flutter?" details:key]);
            return;
        }
//
//        if ([joinQQGroup:groupUin key:key]) {
//            result(@"");
//        }else{
//         result([FlutterError errorWithCode:@"NOT INSTALL IOS QQ" message:@"are you install ios QQ?" details:key]);
//        }

    }else{
         result(FlutterMethodNotImplemented);
    }
}

- (BOOL)joinQQGroup:(NSString *)groupUin key:(NSString *)key{
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", groupUin,key];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else return NO;
}


@end


//@implementation FlutterPluginJoinQqGroupPlugin
//+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//  [SwiftFlutterPluginJoinQqGroupPlugin registerWithRegistrar:registrar];
//}
//@end
