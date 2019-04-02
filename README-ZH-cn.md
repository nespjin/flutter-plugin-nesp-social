# flutter_plugin_nesp_social

A Flutter plugin for social.

[English](./README.md)

***
没有IOS开发环境，所以目前仅支持**Android平台**，欢迎贡献IOS平台代码
****

## 截图
>### 加QQ好友
>
> <img height="540" width="270" align=center src = "./doc/images/android-join-qq-friend.gif"/>

***

> ### 加QQ群
> <img height="540" width="270" align=center src = "./doc/images/android-join-qq-group.gif"/>


***

> ### 错误调用示例
> #### (This is a case of error when calling)
> <img height="540" width="270" align=center src = "./doc/images/android-join-qq-group-no-key.gif"/>

***

> ### 打开微博指定用户
> <img height="540" width="270" align=center src = "./doc/images/android-open-weibo.gif"/>

***

> ### 打开其他软件
> <img height="540" width="270" align=center src = "./doc/images/android-open-other.gif"/>

## 用法 

该项目基于[Flutter](https://flutter.io/developing-packages/), 是一个特定功能的Flutter插件，包含Android和IOS平台实现。

为了帮助你开始使用Flutter, 请参阅
[在线文档](https://flutter.io/docs),该文档提供关于移动开发的教程、示例、指导并且包含全部的API参考。
 


### 加好友

```dart
try {
      isSuccess = await FlutterNespSocial.joinQQFriend(
        qqFriendNumber: "input your qq friend number",
      );
      
    } on PlatformException catch (e) {
      //do something 
    }
```

### 加QQ群

```dart

try {
   isSuccess = await FlutterNespSocial.joinQQGroup(
        androidKey:  "input your android key",
        groupUin:  "input your group uin",
        iosKey: "input your ios key",
      );

    } on PlatformException catch (e) {
        //do something
    }

```

### 打开微博指定用户

```dart

try {
    isSuccess =  await FlutterNespSocial.openWeiboUser(
        uid: “输入你要打开的用户ID”,//打开网页微博,鼠标放在头像下面的关注或粉丝时就能在右下方看见UID
      );
    } on PlatformException catch (e) {
     // do something
    }

```

### 打开其他应用
``` dart

try {
      isCalledOtherApp = await FlutterNespSocial.openOtherApp(
        androidPackageName: "你要打开的应用包名",
        androidClassName: "你要打开的应用Activity的类名",
        iosAppUrl: "你要打开的IOS应用URL",
      );
    } on PlatformException catch (e) {
     //do something
    }

```