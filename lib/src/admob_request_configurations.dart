class AdMobRequestConfigurations {
  /// Maximum content rating that will be shown.
  final String? maxAdContentRating;

  /// Whether to tag as child directed.
  final int? tagForChildDirectedTreatment;

  /// Whether to tag as under age of consent.
  final int? tagForUnderAgeOfConsent;

  /// List of test device ids to set.
  final List<String>? testDeviceIds;

  AdMobRequestConfigurations(
      {this.maxAdContentRating,
      this.tagForChildDirectedTreatment,
      this.tagForUnderAgeOfConsent,
      this.testDeviceIds});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (maxAdContentRating != null)
      json['maxAdContentRating'] = maxAdContentRating;

    if (tagForChildDirectedTreatment != null)
      json['tagForChildDirectedTreatment'] = tagForChildDirectedTreatment;

    if (tagForUnderAgeOfConsent != null)
      json['tagForUnderAgeOfConsent'] = tagForUnderAgeOfConsent;

    if (testDeviceIds != null) json['testDeviceIds'] = testDeviceIds;

    return json;
  }
}

class MaxAdContentRating {
  /// No specified content rating.
  static final String unspecified = "";

  /// Content suitable for general audiences, including families.
  static final String g = "G";

  /// Content suitable for most audiences with parental guidance.
  static final String pg = "PG";

  /// Content suitable for most audiences with parental guidance.
  static final String t = "T";

  /// Content suitable only for mature audiences.
  static final String ma = "MA";
}

class TagForUnderAgeOfConsent {
  /// Tag as under age of consent.
  ///
  /// Indicates the publisher specified that the ad request should receive
  /// treatment for users in the European Economic Area (EEA) under the age
  /// of consent.
  static final int yes = 1;

  /// Tag as NOT under age of consent.
  ///
  /// Indicates the publisher specified that the ad request should not receive
  /// treatment for users in the European Economic Area (EEA) under the age of
  /// consent.
  static final int no = 0;

  /// Do not specify tag for under age of consent.
  ///
  /// Indicates that the publisher has not specified whether the ad request
  /// should receive treatment for users in the European Economic Area (EEA)
  /// under the age of consent.
  static final int unspecified = -1;
}

class TagForChildDirectedTreatment {
  /// Tag for child directed treatment.
  ///
  /// Indicates the publisher specified that the ad request should receive
  /// treatment for users in the European Economic Area (EEA) under the age
  /// of consent.
  static final int yes = 1;

  /// Tag for NOT child directed treatment.
  ///
  /// Indicates the publisher specified that the ad request should not receive
  /// treatment for users in the European Economic Area (EEA) under the age
  /// of consent.
  static final int no = 0;

  /// Do not specify tag for child directed treatment.
  ///
  /// Indicates that the publisher has not specified whether the ad request
  /// should receive treatment for users in the European Economic Area (EEA)
  /// under the age of consent.
  static final int unspecified = -1;
}
