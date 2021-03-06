class AppOpenAd {
  final Map<String, Object> targetingInfo;
  final Duration expiry;
  final String admobAppId;
  final String adUnitId;
  static const APP_OPEN_AD_TEST_ID = 'ca-app-pub-3940256099942544/3419835294';

  AppOpenAd(
    this.admobAppId, {
    this.adUnitId = APP_OPEN_AD_TEST_ID,
    this.targetingInfo,
    this.expiry = const Duration(hours: 4),
  });

  AppOpenAd copyWith(
      {String adUnitId, Map<String, Object> targetingInfo, Duration expiry}) {
    return AppOpenAd(
      this.admobAppId,
      adUnitId: adUnitId == null ? this.adUnitId : adUnitId,
      targetingInfo: targetingInfo == null ? this.targetingInfo : targetingInfo,
      expiry: expiry == null ? this.expiry : expiry,
    );
  }
}
