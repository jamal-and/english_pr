import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../general_exports.dart';
import '../../utils/assets.dart';

class Recorder {
  String correctAnswer;
  final void Function(SpeechRecognitionResult) onResult;
  final void Function(String text, bool isTrue) onStop;

  Recorder({
    this.correctAnswer = '',
    required this.onResult,
    required this.onStop,
  }) {
    speechToText.statusListener = (status) {
      if (status == 'listening') {
        isRecording = true;
      } else if (status == 'done') {
        isRecording = false;
      }
      //isRecording = status == 'listening';
      if (!isRecording) {
        Future.delayed(0.seconds).then((value) {
          stopListening();
        });
      }
    };
  }

  SpeechToText speechToText = SpeechToText();
  String lastWords = '';
  DateTime? lastRecorded;
  DateTime? lastPlayedSoundTime;
  String lastCorrectAnswer = '';
  bool isCorrectAnswer = false;
  AudioPlayer audioPlayer = AudioPlayer();
  bool speechEnabled = false;
  bool isRecording = false;
  Map<String, HighlightedWord> wrongWords = {};
  Map missedWords = {};

  Future<void> startListening() async {
    speechEnabled = await speechToText.initialize();
    hideKeyboard();
    await speechToText.listen(
      onResult: (result) {
        lastWords = result.recognizedWords;
        onResult(result);
        lastRecorded = DateTime.now();
      },
    );
    lastRecorded = DateTime.now().add(3.seconds);
    checkToStop();
  }

  void checkToStop() async {
    if ((DateTime.now().difference(lastRecorded!).inSeconds) > 1) {
      stopListening();
      //update();
    } else {
      await Future.delayed(1.seconds);
      checkToStop();
    }
  }

  void stopListening() async {
    await speechToText.stop();
    isCorrect();
    if (DateTime.now()
            .difference(
              lastPlayedSoundTime ?? DateTime.utc(1999),
            )
            .inSeconds >
        3) {
      if (isCorrectAnswer) {
        lastPlayedSoundTime = DateTime.now();
        lastCorrectAnswer = lastWords;
        await Future.delayed(200.milliseconds);
        await audioPlayer.stop();
        audioPlayer.play(
          AssetSource(
            Assets.assetsSoundsCorrect.replaceFirst('assets/', ''),
          ),
        );
      } else {
        await Future.delayed(200.milliseconds);
        await audioPlayer.stop();
        lastPlayedSoundTime = DateTime.now();
        audioPlayer.play(
          AssetSource(
            Assets.assetsSoundsWrong.replaceFirst('assets/', ''),
          ),
        );
      }
    }
    onStop(
      lastWords,
      isCorrectAnswer,
    );
  }

  bool isCorrect() {
    if (lastWords.isEmpty || correctAnswer.isEmpty) {
      return false;
    }
    String first =
        lastWords.toLowerCase().trim().replaceAll(RegExp('[^A-Za-z0-9]'), '');
    String second = correctAnswer
        .toLowerCase()
        .trim()
        .replaceAll(RegExp('[^A-Za-z0-9]'), '');
    List saidWords = lastWords
        .replaceAll(RegExp('[^A-Za-z0-9 ]'), '')
        .toLowerCase()
        .split(' ');
    List correctWords = correctAnswer
        .replaceAll(RegExp('[^A-Za-z0-9 ]'), '')
        .toLowerCase()
        .split(' ');
    wrongWords.clear();
    for (String i in saidWords) {
      if (!correctWords.contains(i)) {
        wrongWords[i] = HighlightedWord(
          textStyle: textStyle16White.copyWith(color: Colors.red),
        );
      }
    }
    missedWords.clear();
    for (int i = 0; i < correctWords.length; i++) {
      if (correctWords.length == 1) {
        break;
      }
      String currentWord = correctWords[i];
      if (!saidWords.contains(currentWord)) {
        if (i != 0 && i != correctWords.length - 1) {
          missedWords[currentWord] =
              "in '...${correctWords[i - 1]} $currentWord ${correctWords[i + 1]}...'";
        } else if (i == 0) {
          missedWords[currentWord] =
              "before '${correctWords[i + 1]}' at the begging'";
        } else {
          missedWords[currentWord] = "after '${correctWords[i - 1]}'";
        }
        // missedWords.add(i);
        // wrongWords[i] = HighlightedWord(
        //   textStyle: textStyle16Black.copyWith(color: Colors.red),
        // );
      }
    }

    isCorrectAnswer = first == second;
    return isCorrectAnswer;
  }
}
