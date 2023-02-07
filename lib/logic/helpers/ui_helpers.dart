import '../../general_exports.dart';

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
