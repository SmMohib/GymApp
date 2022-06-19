import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4788761803540684/9462524762";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4788761803540684/9462524762";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4788761803540684/7128538297";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4788761803540684/7128538297";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
