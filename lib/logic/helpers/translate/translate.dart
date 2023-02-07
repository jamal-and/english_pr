import 'package:translator/translator.dart';

class Translator {
  final Function(String output) onResult;
  final String to;

  Translator({
    required this.onResult,
    this.to = 'ar',
  });

  final translator = GoogleTranslator();

  Future<void> translate(String input) async {
    var translation = await translator.translate(input, to: to);
    onResult(translation.text);
  }
}
