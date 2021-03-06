import 'dart:async';

import 'package:flutter/services.dart';

class AdmobAppOpenAd {
  static const MethodChannel _channel =
      const MethodChannel('admob_app_open_ad');

  final Map<String, Object>? targetingInfo;
  final Duration expiry;
  final String admobAppId;
  final String adUnitId;
  final bool showAdWheneverOnStart;
  static const APP_OPEN_AD_TEST_ID = 'ca-app-pub-3940256099942544/3419835294';

  AdmobAppOpenAd(
    this.admobAppId, {
    this.targetingInfo,
    this.expiry = const Duration(hours: 4),
    this.adUnitId = APP_OPEN_AD_TEST_ID,
    this.showAdWheneverOnStart = false,
  }) {
    _channel.invokeMethod('init', {
      'expiry': expiry.inMilliseconds,
      'adUnitId': adUnitId,
      'targetingInfo': targetingInfo,
      'showAdWheneverOnStart': showAdWheneverOnStart
    });
  }

  Future<bool> fetchAd() async => await _channel.invokeMethod(
        'fetchAd',
      );

  void showAd() => _channel.invokeMethod('showAd');

  void fetchAndShowAd() async {
    final isAdLoaded = await fetchAd();
    if (isAdLoaded) showAd();
  }
}
