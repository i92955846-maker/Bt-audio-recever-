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
  final WebRTCService _webrtcService = WebRTCService();
  final BluetoothSPP _bluetoothSPP = BluetoothSPP();

  String status = "Disconnected";

  @override
  void initState() {
    super.initState();
    PermissionsHelper.requestPermissions();
  }

  void _connectBluetooth() async {
    bool connected = await _bluetoothSPP.connect();
    setState(() {
      status = connected ? "Bluetooth Connected" : "Failed to Connect";
    });
  }

  void _startWebRTC() {
    _webrtcService.initConnection();
    setState(() {
      status = "WebRTC Initialized";
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
            Text("Status: $status"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _connectBluetooth,
              child: const Text("Connect Bluetooth"),
            ),
            ElevatedButton(
              onPressed: _startWebRTC,
              child: const Text("Start WebRTC"),
            ),
          ],
        ),
      ),
    );
  }
}
