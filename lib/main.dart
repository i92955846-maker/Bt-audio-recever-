import 'package:flutter/material.dart';
import 'permissions_helper.dart';
import 'audio_receiver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Forwarding App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isConnected = false;
  String _status = "Disconnected";

  @override
  void initState() {
    super.initState();
    PermissionsHelper.requestPermissions();
    audioReceiver.init();
  }

  @override
  void dispose() {
    audioReceiver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Forwarding"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Status: $_status"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isConnected = !_isConnected;
                  _status = _isConnected ? "Connected" : "Disconnected";
                });
              },
              child: Text(_isConnected ? "Disconnect" : "Connect"),
            ),
          ],
        ),
      ),
    );
  }
}
