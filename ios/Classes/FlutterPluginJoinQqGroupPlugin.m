#import "FlutterPluginJoinQqGroupPlugin.h"
#import <flutter_plugin_join_qq_group/flutter_plugin_join_qq_group-Swift.h>

@implementation FlutterPluginJoinQqGroupPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPluginJoinQqGroupPlugin registerWithRegistrar:registrar];
}
@end
