import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothSPP {
  static BluetoothConnection? _connection;

  static Future<bool> connect() async {
    try {
      // Apne paired device ka MAC address yaha likhna hoga
      String address = "00:11:22:33:44:55";

      _connection = await BluetoothConnection.toAddress(address);
      print('Connected to the device');
      return true;
    } catch (e) {
      print("Bluetooth connect error: $e");
      return false;
    }
  }

  static Future<void> disconnect() async {
    await _connection?.close();
    _connection = null;
  }
}
