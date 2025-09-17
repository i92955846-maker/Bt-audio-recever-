import 'package:flutter_webrtc/flutter_webrtc.dart';

class AudioReceiver {
  RTCPeerConnection? _peerConnection;
  MediaStream? _remoteStream;

  Future<void> init() async {
    // Peer connection configuration
    Map<String, dynamic> config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ]
    };

    _peerConnection = await createPeerConnection(config);

    // Remote stream setup
    _remoteStream = await createLocalMediaStream('remoteStream');
    _peerConnection?.onTrack = (event) {
      if (event.streams.isNotEmpty) {
        _remoteStream = event.streams[0];
      }
    };
  }

  MediaStream? get remoteStream => _remoteStream;

  Future<void> close() async {
    await _peerConnection?.close();
    _peerConnection = null;
    _remoteStream = null;
  }
}
