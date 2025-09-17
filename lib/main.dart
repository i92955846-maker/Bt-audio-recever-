import 'package:flutter/material.dart';
import 'webrtc_service.dart';
import 'bluetooth_spp.dart';
import 'permissions_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BT Audio Receiver',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isConnected = false;
  String _status = "Disconnected";

  @override
  void initState() {
    super.initState();
    PermissionsHelper.requestPermissions();
  }

  Future<void> _connect() async {
    setState(() {
      _status = "Connecting...";
    });

    bool connected = await BluetoothSPP.connect();
    if (connected) {
      await WebRTCService.start();
    }

    setState(() {
      _isConnected = connected;
      _status = connected ? "Connected" : "Failed to connect";
    });
  }

  Future<void> _disconnect() async {
    await BluetoothSPP.disconnect();
    await WebRTCService.stop();

    setState(() {
      _isConnected = false;
      _status = "Disconnected";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BT Audio Receiver")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _status,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isConnected ? _disconnect : _connect,
              child: Text(_isConnected ? "Disconnect" : "Connect"),
            ),
          ],
        ),
      ),
    );
  }
}
