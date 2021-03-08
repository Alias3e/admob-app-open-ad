import 'dart:async';

import 'package:admob_app_open_ad/admob_app_open_ad.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // AdmobOptions options = AdmobOptions();
    AdMobTargetingInfo targetingInfo = AdMobTargetingInfo(
      keywords: <String>[
        'gacha',
        'arknights',
        'anime',
        'tower defense',
        'tower defence'
      ],
      contentUrl: 'https://arknights.com',
    );

    AdMobRequestConfigurations configurations = AdMobRequestConfigurations(
      maxAdContentRating: MaxAdContentRating.g,
      tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified,
      tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.unspecified,
      testDeviceIds: ['abcdefghijk'],
    );

    final ad = AppOpenAds('ca-app-pub-3940256099942544~4354546703',
        expiry: Duration(hours: 3),
        adMobRequestConfiguration: configurations,
        adMobTargetingInfo: targetingInfo,
        showAdWheneverOnStart: false);
    ad.fetchAndShowAd();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
