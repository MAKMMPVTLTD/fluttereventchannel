package com.example.random_no;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Random;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private EventChannel channel;
    int randomNumber;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(Objects.requireNonNull(this.getFlutterEngine()));

        // Prepare channel
        channel = new EventChannel(this.getFlutterEngine().getDartExecutor().getBinaryMessenger(),
                "flutterEventChannel");
        channel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object listener, EventChannel.EventSink eventSink) {
                Log.d("MMPVT", "Called Here 23");
                startListening(listener, eventSink);
            }

            @Override
            public void onCancel(Object listener) {
                cancelListening(listener);
            }
        });
    }

    // Listeners
    private Map<Object, Runnable> listeners = new HashMap<>();

    void startListening(Object listener, EventChannel.EventSink emitter) {
        // Prepare a timer like self calling task
        final Handler handler = new Handler();

        listeners.put(listener, new Runnable() {
            @Override
            public void run() {
                if (listeners.containsKey(listener)) {

                    randomNumber = new Random().nextInt(80);
                    // Send some value to callback
                    emitter.success("Hello listener! " + randomNumber);//+ (System.currentTimeMillis() / 1000)
                    handler.postDelayed(this, 1000);
                }
            }
        });

        Log.d("MMPVT", "Called Here 0");

        // Run task
        handler.postDelayed(listeners.get(listener), 1000);
    }

    void cancelListening(Object listener) {
        // Remove callback
        listeners.remove(listener);
        Log.d("MM", "Count: " + listeners.size());
    }


}
