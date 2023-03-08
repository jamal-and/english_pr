import 'package:english_pr/general_exports.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyStorage {
  final box = GetStorage();
  late List favoriteList;
  late List f500QuotesChallenge;

  MyStorage() {
    box.writeIfNull('fav', []);
    favoriteList = box.read('fav');
    f500QuotesChallenge = box.read('500Ch') ?? [];
    if (f500QuotesChallenge.isEmpty) {
      for (int i = 0; i < quotes.length; i++) {
        if (i == 500) {
          break;
        }
        dynamic element = quotes[i];
        f500QuotesChallenge.add(
          {
            'text': element['text'],
            'isDone': false,
          },
        );
      }
      box.write('500Ch', f500QuotesChallenge);
    }
  }

  Future<dynamic> read(String key) async {
    return await box.read(key);
  }

  void write(String key, dynamic value) async {
    return await box.write(key, value);
  }

  void remove(String key) async {
    return await box.remove('quote');
  }

  void addToFav(Map item) {
    if (favoriteList.contains(item)) {
      return;
    }
    favoriteList.add(item);
    box.write('fav', favoriteList);
    Get.forceAppUpdate();
  }

  void removeFromFav(Map item) {
    if (!isInFavorite(item)) {
      return;
    }
    favoriteList.remove(item);
    box.write('fav', favoriteList);
    Get.forceAppUpdate();
  }

  void markAsDone(String text) {
    print('LookingFor');
    Map? item = f500QuotesChallenge
        .firstWhereOrNull((element) => element['text'] == text);
    int indexOfItem = f500QuotesChallenge.indexOf(item);
    if (indexOfItem != -1) {
      print('Adding');
      f500QuotesChallenge[indexOfItem]['isDone'] = true;
      box.write('500Ch', f500QuotesChallenge);
      print('Added');
    }
  }
}
