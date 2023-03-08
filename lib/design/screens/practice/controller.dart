import 'dart:developer';
import 'dart:math' as math;

import 'package:english_pr/general_exports.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class PracticeController extends GetxController {
  late Recorder recorder;
  late TextToSpeechHelper textToSpeechHelper;
  late Translator translator;
  MyStorage myStorage = MyStorage();
  OverlayEntry? overlayEntry;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isRecording = false;
  bool isCorrectAnswer = false;
  String lastWords = '';
  String translation = '';
  GlobalKey inputKey = GlobalKey();
  GlobalKey translationKey = GlobalKey();
  RenderBox? inputBox;
  Offset? inputPosition;
  RenderBox? transBox;
  Offset? transPosition;
  bool loadingTranslation = false;
  bool loadingTextToSpeech = false;
  bool loadingMic = false;
  bool isFavorite = false;
  Map? currentQuote;

  @override
  void onInit() async {
    super.onInit();
    textEditingController.text = Get.arguments ?? '';
    checkFavorite();
    scrollController.addListener(scrollListener);
    recorder = Recorder(
      onResult: _onSpeechResult,
      correctAnswer: textEditingController.text,
      onStop: (text, isTrue) {
        isCorrectAnswer = isTrue;
        isRecording = false;
        update();
      },
    );
    textToSpeechHelper = TextToSpeechHelper(text: textEditingController.text);
    translator = Translator(
      onResult: onTranslated,
    );
  }

  @override
  void onReady() {
    super.onReady();
    handleTheWidgets();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(scrollListener);
  }

  void scrollListener() {
    hideKeyboard();
    translation = '';
    update();
  }

  void _startListening() async {
    recorder.correctAnswer = textEditingController.text;
    loadingMic = true;
    update();
    await recorder.startListening();
    loadingMic = false;
    isRecording = true;
    update();
  }

  void _stopListening() async {
    isRecording = false;
    recorder.stopListening();
    update();
    log(lastWords);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (isRecording == false) {
      return;
    }
    log('confidence: ${result.confidence.toString()}');
    lastWords = result.recognizedWords;
    if (isCorrect()) {
      isRecording = false;
      myStorage.markAsDone(textEditingController.text);
      _stopListening();
      recorder.missedWords.clear();
    }
    update();
  }

  void record() {
    if (!isRecording) {
      _startListening();
    } else {
      _stopListening();
    }
  }

  void listen() async {
    textToSpeechHelper.text = textEditingController.text;
    loadingTextToSpeech = true;
    update();
    await textToSpeechHelper.listen();
    loadingTextToSpeech = false;
    update();
  }

  Future<void> translate() async {
    log('translating');
    loadingTranslation = true;
    update();
    await translator.translate(textEditingController.text);
    loadingTranslation = false;
    update();
  }

  void onTranslated(result) async {
    translation = result;
    update();
    await Future.delayed(0.1.seconds);
    update();
    // handleTheWidgets();
  }

  void cleanTranslation() {
    translation = '';
    update();
  }

  bool isCorrect() {
    return recorder.isCorrect();
  }

  Map getRandomQuote() {
    Map item = quotes[math.Random().nextInt(quotes.length)];
    lastWords = '';
    recorder.missedWords.clear();
    log(item.toString());
    textEditingController.text = item['text'];
    update();
    currentQuote = item;
    checkFavorite();
    return item;
  }

  bool checkFavorite() {
    Map? item = myStorage.favoriteList.firstWhereOrNull(
        (element) => element['text'] == textEditingController.text);
    isFavorite = myStorage.favoriteList.contains(item);
    update();
    return isFavorite;
  }

  void addToFav() {
    if (checkFavorite()) {
      return;
    }
    Map item = {
      'text': textEditingController.text,
      'isDone': isCorrectAnswer,
    };
    myStorage.addToFav(item);
    update();
  }

  void toggleFav() {
    if (checkFavorite()) {
      removeFromFav();
    } else {
      addToFav();
    }
    checkFavorite();
  }

  void removeFromFav() {
    if (checkFavorite()) {
      Map? item = myStorage.favoriteList.firstWhereOrNull(
        (element) => element['text'] == textEditingController.text,
      );
      if (item != null) {
        myStorage.removeFromFav(item);
      }
    }
  }

  void handleTheWidgets() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(3.seconds);
        inputBox = inputKey.currentContext?.findRenderObject() as RenderBox;
        // transBox =
        //     translationKey.currentContext?.findRenderObject() as RenderBox;
        var safePadding = MediaQuery.of(Get.context!).padding.top;
        inputPosition = inputBox!.localToGlobal(
          Offset.zero,
          // Offset(
          //   -horizontalSpacing,
          //   -verticalSpacing - safePadding,
          // ),
        );
        // transPosition = transBox!.localToGlobal(
        //   Offset(
        //     -horizontalSpacing,
        //     -verticalSpacing - safePadding,
        //   ),
        // );
        update();
      },
    );
  }
}
