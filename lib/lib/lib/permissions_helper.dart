import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<void> requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.microphone,
      Permission.speech,
    ].request();
  }
}
