import 'dart:async';

import 'package:flutter/services.dart';

import 'admob_request_configurations.dart';
import 'admob_targeting_info.dart';

class AppOpenAds {
  static const MethodChannel _channel =
      const MethodChannel('admob_app_open_ad');
  final Duration expiry;
  final String admobAppId;
  final String adUnitId;
  final bool showAdWheneverOnStart;
  final AdMobTargetingInfo? adMobTargetingInfo;
  final AdMobRequestConfigurations? adMobRequestConfiguration;
  static const APP_OPEN_ADS_TEST_ID = 'ca-app-pub-3940256099942544/3419835294';

  AppOpenAds(
    this.admobAppId, {
    this.adMobRequestConfiguration,
    this.adMobTargetingInfo,
    this.expiry = const Duration(hours: 4),
    this.adUnitId = APP_OPEN_ADS_TEST_ID,
    this.showAdWheneverOnStart = false,
  }) {
    _channel.invokeMethod('init', {
      'expiry': expiry.inMilliseconds,
      'adUnitId': adUnitId,
      'showAdWheneverOnStart': showAdWheneverOnStart,
      'requestConfigurations': adMobRequestConfiguration?.toJson(),
      'targetingInfo': adMobTargetingInfo?.toJson(),
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
