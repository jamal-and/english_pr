import 'package:english_pr/general_exports.dart';
import 'package:get/get.dart';

bool isInFavorite(Map item) {
  Map? itemD = MyStorage().favoriteList.firstWhereOrNull(
        (element) => element['text'] == item['text'],
      );
  return itemD != null;
}
