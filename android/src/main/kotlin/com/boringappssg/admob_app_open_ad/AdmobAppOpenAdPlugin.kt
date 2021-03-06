package com.boringappssg.admob_app_open_ad

import android.app.Application
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.ads.MobileAds

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/** AdmobAppOpenAdPlugin */
class AdmobAppOpenAdPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var applicationContext: Context

    private lateinit var appOpenAdManager: AppOpenAdManager

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "admob_app_open_ad")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
        MobileAds.initialize(applicationContext)
        appOpenAdManager = AppOpenAdManager(applicationContext as Application)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        when (call.method) {
            "init" -> {
                val builder = ManagerOptions.Builder()
                val expiry = call.argument<Int>("expiry")
                if (expiry != null)
                    builder.expiry(expiry.toLong())
                val targetingInfo = call.argument<Map<String, Any>>("targetingInfo")
                if (targetingInfo != null)
                    builder.targetingInfo(targetingInfo)
                val adUnitId = call.argument<String>("adUnitId")
                if (adUnitId != null)
                    builder.adUnitId(adUnitId)
                val showAdWheneverOnStart = call.argument<Boolean>("showAdWheneverOnStart")
                if (showAdWheneverOnStart != null)
                    builder.showAdWheneverOnStart(showAdWheneverOnStart)
                val options = builder.build()
                appOpenAdManager.options = options
            }
            "fetchAd" -> {
                CoroutineScope(Dispatchers.Main).launch {
                    val loadAdSuccess = appOpenAdManager.fetchAd()
                    result.success(loadAdSuccess)
                }
            }
            "showAd" -> {
                appOpenAdManager.showAd()
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
