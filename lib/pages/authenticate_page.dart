import 'package:local_auth/local_auth.dart';

class Authenticate {
  static final auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async =>
      await auth.canCheckBiometrics || await auth.isDeviceSupported();

  static Future<bool> authentication() async {
    try {
      if (!await canAuthenticate()) return false;
      return await auth.authenticate(localizedReason: "get into the app");
    } catch (e) {
      print("error $e");
      return false;
    }
  }
}
