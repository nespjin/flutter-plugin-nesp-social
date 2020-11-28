package com.nesp.sdk.flutter.flutter_plugin_nesp_social

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterPluginNespSocialPlugin */
class FlutterPluginNespSocialPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_plugin_nesp_social")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "joinQQGroup") {
            val key: String? = call.argument("androidKey")
            if (key == null || key.isEmpty()) {
                result.error("Key is Empty", "Are you set androidKey on Flutter?", key)
                return
            }
            if (joinQQGroup(key)) {
                result.success(true)
            } else {
                result.error("NOT INSTALL QQ OR TIM OR VERSION IS LOWER", "Are you install the new version mobile QQ or TIM on your Android device?", key)
            }
        } else if (call.method == "openWeiboUser") {
            val uid: String? = call.argument("uid")
            if (uid == null || uid.isEmpty()) {
                result.error("UID is Empty", "Are you set uid on Flutter?", uid)
                return
            }
            if (openWeiboUser(uid)) {
                result.success(true)
            } else {
                result.error("NOT INSTALL WEIBO", "Are you install mobile weibo on your Android device?", uid)
            }

        } else if (call.method == "joinQQFriend") {
            val qqFriendNumber: String? = call.argument("qqFriendNumber")
            if (qqFriendNumber == null || qqFriendNumber.isEmpty()) {
                result.error("UID is Empty", "Are you set qqFriendNumber on Flutter?", qqFriendNumber)
                return
            }
            if (joinQQFriend(qqFriendNumber)) {
                result.success(true)
            } else {
                result.error("NOT INSTALL QQ OR TIM", "Are you install mobile QQ or TIM on your Android device?", qqFriendNumber)
            }

        } else if (call.method == "openOtherApp") {
            val androidPackageName: String? = call.argument("androidPackageName")
            if (androidPackageName == null || androidPackageName.isEmpty()) {
                result.error("androidPackageName is Empty", "Are you set androidPackageName on Flutter?", androidPackageName)
                return
            }

            val androidClassName: String? = call.argument("androidClassName")
            if (androidClassName == null || androidClassName.isEmpty()) {
                result.error("androidClassName is Empty", "Are you set androidClassName on Flutter?", androidClassName)
                return
            }

            try {
                if (openOtherApp(androidPackageName, androidClassName)) {
                    result.success(true)
                } else {
                    result.error("NOT FOUND APP", "This andriod device not install $androidPackageName app!", androidPackageName)
                }
            } catch (e: Exception) {
                result.error("EXCEPTION", e.message, androidClassName)
            }

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun joinQQFriend(qqFriendNumber: String): Boolean {
        if (!isAppInstalled("com.tencent.mobileqq")
                && !isAppInstalled("com.tencent.tim")) return false
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse("mqqwpa://im/chat?chat_type=wpa&uin=$qqFriendNumber&version=1"))
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
        context.startActivity(intent)
        return true
    }


    /****************
     *打开QQ群
     * @param key 由官网生成的key
     * @return 返回true表示呼起手Q成功，返回fals表示呼起失败
     */
    private fun joinQQGroup(key: String): Boolean {
        val intent = Intent()
        intent.data = Uri.parse("mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3D$key")
        // 此Flag可根据具体产品需要自定义，如设置，则在加群界面按返回，返回手Q主界面，不设置，按返回会返回到呼起产品界面
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
        return try {
            context.startActivity(intent)
            true
        } catch (e: Exception) {
            // 未安装手Q或安装的版本不支持
            false
        }

    }

    /**
     * 打开微博用户
     * @param context
     * @param uidValue 用户ID 打开网页微博,鼠标放在头像下面的关注或粉丝时就能在右下方看见UID
     * NESPTechnology UID=3619635672
     */
    private fun openWeiboUser(uidValue: String): Boolean {
        val weiboPackageName = "com.sina.weibo"
        if (!isAppInstalled(weiboPackageName)) return false

        val intent = Intent()
        val componentName = ComponentName(weiboPackageName, "com.sina.weibo.page.ProfileInfoActivity")
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
        intent.component = componentName
        intent.putExtra("uid", uidValue)
        context.startActivity(intent)
        return true
    }

    @Throws(Exception::class)
    private fun openOtherApp(androidPackageName: String, androidClassName: String): Boolean {

        if (!isAppInstalled(androidPackageName)) return false

        val intent = Intent()
        val componentName = ComponentName(androidPackageName, androidClassName)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
        intent.component = componentName
        try {
            context.startActivity(intent)
        } catch (e: Exception) {
            throw Exception(e)
        }

        return true
    }


    /**
     * 检查APP是否安装
     *
     * @param packageName 应用包名
     */
    private fun isAppInstalled(packageName: String): Boolean {
        val packageManager: PackageManager = context.packageManager
        packageManager.getInstalledPackages(0).forEach { packageInfo ->
            if (packageInfo.packageName == packageName) {
                return true
            }
        }
        return false
    }

}
