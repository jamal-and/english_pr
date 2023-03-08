import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

import '../ui_helpers.dart';

class TextToSpeechHelper {
  String text;
  FlutterTts flutterTts = FlutterTts();
  bool isTtsPlaying = false;
  TextToSpeechHelper({
    required this.text,
  }) {
    flutterTts.setSharedInstance(true);
    flutterTts.setSpeechRate(Platform.isAndroid ? 0.3 : 0.35);
    // await flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback,
    //     [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker]);
    flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.ambient,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
      ],
      IosTextToSpeechAudioMode.voiceChat,
    );
    ttsStatesHandlers();
  }

  void ttsStatesHandlers() {
    flutterTts.setCancelHandler(() {
      isTtsPlaying = false;
    });
    flutterTts.setCompletionHandler(() {
      isTtsPlaying = false;
    });
    flutterTts.setContinueHandler(() {
      isTtsPlaying = true;
    });
    flutterTts.setPauseHandler(() {
      isTtsPlaying = false;
    });
    flutterTts.setStartHandler(() {
      isTtsPlaying = true;
    });
  }

  Future<void> listen() async {
    if (isTtsPlaying) {
      flutterTts.stop();
      return;
    }
    hideKeyboard();
    flutterTts.stop();
    await flutterTts.speak(text);
    //flutterTts.stop();
  }
}
