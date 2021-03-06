package com.boringappssg.admob_app_open_ad

class ManagerOptions private constructor(
        val adUnitId: String,
        val keywords: List<String>,
        val expiry: Long,
        val contentUrl: String,
        val showAdWheneverOnStart: Boolean
) {
    data class Builder(
            var targetingInfo: Map<String, Any> = emptyMap(),
            var expiry: Long = 3600000 * 4,
            var adUnitId: String = "ca-app-pub-3940256099942544/3419835294",
            var showAdWheneverOnStart: Boolean = false
    ) {

        fun targetingInfo(targetingInfo: Map<String, Any>) = apply { this.targetingInfo = targetingInfo }
        fun expiry(expiry: Long) = apply { this.expiry = expiry }
        fun adUnitId(adUnitId: String) = apply { this.adUnitId = adUnitId }
        fun showAdWheneverOnStart(showAdWheneverOnStart: Boolean) = apply { this.showAdWheneverOnStart = showAdWheneverOnStart }
        fun build(): ManagerOptions {
            var keywords = emptyList<String>()
            var contentUri = ""
            if (targetingInfo.isNotEmpty()) {
                if (targetingInfo.containsKey("keywords"))
                    keywords = (targetingInfo["keywords"] as List<*>).map { it as String }

                if (targetingInfo.containsKey("contentUrl"))
                    contentUri = targetingInfo["contentUrl"] as String
            }

            return ManagerOptions(this.adUnitId, keywords, this.expiry, contentUri, this.showAdWheneverOnStart)
        }
    }
}
