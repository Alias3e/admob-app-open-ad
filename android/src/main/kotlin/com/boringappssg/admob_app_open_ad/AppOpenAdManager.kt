package com.boringappssg.admob_app_open_ad

import android.app.Activity
import android.app.Application
import android.os.Bundle
import android.util.Log
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.ProcessLifecycleOwner
import com.google.android.gms.ads.*
import com.google.android.gms.ads.appopen.AppOpenAd
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.util.*
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class AppOpenAdManager constructor(
        private val myApplication: Application)
    : Application.ActivityLifecycleCallbacks, LifecycleObserver {
    private var isShowingAd: Boolean = false
    private val LOG_TAG = "AppOpenAdManager"

    private var appOpenAd: AppOpenAd? = null
    private var currentActivity: Activity? = null
    private var loadTime: Long = 0
    var options: ManagerOptions? = null
        set(value) {
            field = value
            if (value != null) {
                if (value.showAdWheneverOnStart)
                    ProcessLifecycleOwner.get().lifecycle.addObserver(this)
            }
        }

    init {
        this.myApplication.registerActivityLifecycleCallbacks(this)
    }

    /** LifecycleObserver methods  */
    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    fun onStart() {
        Log.i("AppOpenManager", "onStart()")
        showAd()
    }


    /** Request an ad  */
    suspend fun fetchAd(): Boolean = suspendCoroutine { cont ->
        if (options == null)
            throw Exception("App Open Ad not initialized.")
        else {
            Log.i(LOG_TAG, "Fetching ad")
            val request = getAdRequest()
            Log.i(LOG_TAG, "Loading App Open Ad")
            AppOpenAd.load(
                    myApplication, options?.adUnitId, request,
                    AppOpenAd.APP_OPEN_AD_ORIENTATION_PORTRAIT, object : AppOpenAd.AppOpenAdLoadCallback() {

                /**
                 * Called when an app open ad has loaded.
                 *
                 * @param ad the loaded app open ad.
                 */
                override fun onAppOpenAdLoaded(ad: AppOpenAd) {
                    Log.i(LOG_TAG, "onAppOpenAdLoaded")
                    this@AppOpenAdManager.appOpenAd = ad
                    this@AppOpenAdManager.loadTime = Date().time
                    cont.resume(true)
                }

                /**
                 * Called when an app open ad has failed to load.
                 *
                 * @param loadAdError the error.
                 */
                override fun onAppOpenAdFailedToLoad(loadAdError: LoadAdError?) {
                    // Handle the error.
                    cont.resume(false)
                }
            })
        }

    }

    fun showAd() {
        if (options == null)
            throw Exception("App Open Ad not initialized.")
        else {
            if (isAdAvailable() && !isShowingAd) {
                val fullScreenContentCallback: FullScreenContentCallback = object : FullScreenContentCallback() {
                    override fun onAdDismissedFullScreenContent() {
                        // Set the reference to null so isAdAvailable() returns false.
                        this@AppOpenAdManager.appOpenAd = null
                        isShowingAd = false
                        CoroutineScope(Dispatchers.Main).launch {
                            fetchAd()
                        }
                    }

                    override fun onAdFailedToShowFullScreenContent(adError: AdError?) {
                        if (adError != null)
                            Log.i(LOG_TAG, adError.message)
                    }

                    override fun onAdShowedFullScreenContent() {
                        isShowingAd = true
                    }
                }
                appOpenAd?.fullScreenContentCallback = fullScreenContentCallback
                if (currentActivity != null)
                    appOpenAd?.show(currentActivity!!)
            } else
                CoroutineScope(Dispatchers.Main).launch {
                    fetchAd()
                }
        }


    }

    override fun onActivityCreated(activity: Activity, p1: Bundle?) {
    }

    override fun onActivityStarted(activity: Activity) {
        currentActivity = activity
    }

    override fun onActivityResumed(activity: Activity) {
        currentActivity = activity
    }

    override fun onActivityPaused(activity: Activity) {

    }

    override fun onActivityStopped(activity: Activity) {

    }

    override fun onActivitySaveInstanceState(activity: Activity, p1: Bundle) {

    }

    override fun onActivityDestroyed(activity: Activity) {
        currentActivity = null
    }

    /** Creates and returns ad request.  */
    private fun getAdRequest(): AdRequest? {
        val builder = AdRequest.Builder()

        if (options != null) {
            options?.keywords?.forEach {
                builder.addKeyword(it)
            }
            if (options!!.contentUrl.isNotEmpty())
                builder.setContentUrl(options?.contentUrl)
        }
        return builder.build()
    }

    /** Utility method to check if ad was loaded more than n hours ago.  */
    private fun adHasNotExpired(): Boolean {
        val dateDifference: Long = Date().time - this.loadTime
        return if (options != null)
            dateDifference < options!!.expiry
        else
            dateDifference < 3600000 * 4
    }


    /** Utility method that checks if ad exists and can be shown.  */
    private fun isAdAvailable(): Boolean {
        return appOpenAd != null && adHasNotExpired()
    }
}