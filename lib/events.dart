import 'package:flutter/services.dart';

const _channel = EventChannel('flutterEventChannel');

typedef void Listener(dynamic msg);
typedef void CancelListening();

int nextListenerId = 1;

CancelListening startListening(Listener listener) {
  var subscription = _channel.receiveBroadcastStream(nextListenerId++).listen(listener, cancelOnError: true);

  return () {
    subscription.cancel();
  };
}
