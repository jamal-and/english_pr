import 'package:english_pr/general_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ListedScreen extends StatelessWidget {
  const ListedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListedController>(
      init: ListedController(),
      builder: (ListedController controller) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.gradientColors,
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: generalPadding,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.back,
                          color: AppColors.white,
                          size: horizontalSpacing * 1.5,
                        ),
                        generalSmallBox,
                        Expanded(
                          child: CupertinoSearchTextField(
                            backgroundColor: AppColors.white,
                            onChanged: controller.onSearch,
                            controller: controller.textEditingController,
                          ),
                        ),
                      ],
                    ),
                    generalBox,
                    Row(
                      children: [
                        TagItem(
                          onPress: () {
                            controller.showDone = !controller.showDone;
                            controller.showTodo = false;
                            controller.filter();
                          },
                          isActive: controller.showDone,
                          text: 'Done',
                        ),
                        generalSmallBox,
                        TagItem(
                          onPress: () {
                            controller.showTodo = !controller.showTodo;
                            controller.showDone = false;
                            controller.filter();
                          },
                          isActive: controller.showTodo,
                          text: 'Todo',
                        ),
                        generalSmallBox,
                        TagItem(
                          onPress: () {
                            controller.showFav = !controller.showFav;
                            controller.filter();
                          },
                          isActive: controller.showFav,
                          text: 'Favorite',
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.list2view.length,
                        padding: EdgeInsets.symmetric(
                          vertical: verticalSpacing / 2,
                        ),
                        itemBuilder: (context, index) {
                          Map item = controller.list2view[index];
                          return GestureDetector(
                            onTap: () {
                              controller.onItemPress(item);
                            },
                            child: Container(
                              decoration: cardDecoration(),
                              padding: generalPadding,
                              margin: EdgeInsets.symmetric(
                                vertical: verticalSpacing / 2,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['text'],
                                    ),
                                  ),
                                  generalSmallBox,
                                  Container(
                                    decoration: circleDecoration(
                                      color: item['isDone']
                                          ? Colors.green
                                          : Colors.grey.withOpacity(0.3),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.check_mark,
                                      color: item['isDone']
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  generalSmallBox,
                                  GestureDetector(
                                    onTap: () {
                                      if (isInFavorite(item)) {
                                        controller.removeFromFav(item);
                                      } else {
                                        controller.addToFav(item);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: verticalSpacing / 2,
                                      ),
                                      color: Colors.transparent,
                                      child: Icon(
                                        isInFavorite(item)
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TagItem extends StatelessWidget {
  const TagItem({
    super.key,
    required this.onPress,
    required this.isActive,
    required this.text,
  });
  final Function() onPress;
  final bool isActive;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: cardDecoration(
          color: isActive ? AppColors.primary : AppColors.shapeBackground,
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing / 8,
          horizontal: horizontalSpacing / 2,
        ),
        child: Text(
          text,
          style: textStyle14BlackSemiBold.copyWith(
            color: isActive ? AppColors.white : AppColors.textLight,
          ),
        ),
      ),
    );
  }
}
