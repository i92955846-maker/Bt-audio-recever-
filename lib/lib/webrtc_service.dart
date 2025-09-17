import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  RTCPeerConnection? _peerConnection;

  Future<void> init() async {
    final config = {
      "iceServers": [
        {"urls": "stun:stun.l.google.com:19302"}
      ]
    };
    _peerConnection = await createPeerConnection(config);
  }

  Future<void> close() async {
    await _peerConnection?.close();
    _peerConnection = null;
  }
}
