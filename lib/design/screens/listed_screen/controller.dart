import 'package:english_pr/general_exports.dart';
import 'package:english_pr/logic/routes.dart';
import 'package:get/get.dart';

class ListedController extends GetxController {
  List list = [];
  List list2view = [];
  MyStorage myStorage = MyStorage();
  bool showDone = false;
  bool showFav = false;
  bool showTodo = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    list = Get.arguments ?? myStorage.favoriteList;
    list2view = List.from(list);
    list2view.sort((a, b) {
      if (a['isDone']) {
        return 1;
      } else {
        return 0;
      }
    });
  }

  void onItemPress(Map item) {
    Get.toNamed(routePractice, arguments: item['text']);
  }

  void filter() {
    print('Filtred');

    list2view = list.where(
      (element) {
        if (showDone && !element['isDone']) {
          return false;
        }
        if (showTodo && element['isDone']) {
          return false;
        }
        if (showFav && !myStorage.favoriteList.contains(element)) {
          return false;
        }
        if (!element['text']
            .toLowerCase()
            .contains(textEditingController.text.toLowerCase())) {
          return false;
        }
        return true;

        // if (!showDone && !showTodo) {
        //   if (showFav) {
        //     return (element['text'].contains(textEditingController.text) &&
        //         myStorage.favoriteList.contains(element));
        //   } else {
        //     return (element['text'].contains(textEditingController.text));
        //   }
        // }
        // if (showDone) {
        //   return (element['text'].contains(textEditingController.text) &&
        //       element['isDone'] == showDone &&
        //       myStorage.favoriteList.contains(element));
        // } else if (showTodo) {
        //   return (element['text'].contains(textEditingController.text) &&
        //       element['isDone'] == false &&
        //       myStorage.favoriteList.contains(element));
        // } else if (showFav) {
        //   return (element['text'].contains(textEditingController.text) &&
        //       myStorage.favoriteList.contains(element));
        // }

        return (element['text'].contains(textEditingController.text));
      },
    ).toList();
    update();
  }

  void onSearch(String text) {
    filter();
  }

  void addToFav(Map item) {
    myStorage.addToFav(item);
    update();
  }

  void removeFromFav(Map item) {
    myStorage.removeFromFav(item);
    update();
  }
}
