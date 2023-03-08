import 'package:avatar_glow/avatar_glow.dart';
import 'package:english_pr/general_exports.dart';
import 'package:english_pr/logic/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PracticeController(),
      builder: (PracticeController controller) {
        return GestureDetector(
          onTap: () {
            hideKeyboard();
            controller.cleanTranslation();
          },
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: kDeviceHeight,
                  width: kDeviceWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.gradientColors,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      padding:
                          generalPadding.copyWith(bottom: verticalSpacing * 8),
                      controller: controller.scrollController,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  CupertinoButton(
                                    minSize: 0,
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      CupertinoIcons.back,
                                      color: AppColors.white,
                                      size: horizontalSpacing * 1.5,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                              //generalBox,
                              generalBox,
                              AnimatedSize(
                                duration: 2.seconds,
                                curve: Curves.easeOutBack,
                                child: SvgPicture.asset(
                                  Assets.assetsIconsRecord,
                                  placeholderBuilder: (context) => Container(),
                                ),
                              ),
                              Text(
                                'Pronunciation Practice',
                                style: textH1White,
                              ),
                              generalBox,
                              CTextInput(
                                controller: controller.textEditingController,
                                key: controller.inputKey,
                                hint: 'Enter your favorite phrase',
                                onChange: (v) {
                                  controller.lastWords = '';
                                  controller.checkFavorite();
                                  controller.update();
                                },
                                enable: true,
                                bottom: Container(
                                  color: AppColors.primary.withOpacity(0.2),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: controller.loadingTranslation
                                            ? const CircularProgressIndicator
                                                .adaptive()
                                            : CIconButton(
                                                icon: Icons.translate,
                                                onPress: () async {
                                                  await controller.translate();
                                                },
                                              ),
                                      ),
                                      Expanded(
                                        child: CIconButton(
                                          icon: controller.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          onPress: () {
                                            controller.toggleFav();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: controller.loadingTextToSpeech
                                            ? const CircularProgressIndicator
                                                .adaptive()
                                            : CIconButton(
                                                icon: CupertinoIcons.speaker_3,
                                                onPress: () {
                                                  controller.listen();
                                                },
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        controller.getRandomQuote();
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        'Random Quote',
                                        style: textStyle16White.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    generalSmallBox,
                                  ],
                                ),
                              ),

                              ClipRRect(
                                borderRadius: generalRadius,
                                child: AnimatedSize(
                                  duration: 200.milliseconds,
                                  child: Container(
                                    height:
                                        controller.lastWords.isEmpty ? 0 : null,
                                    width:
                                        controller.lastWords.isEmpty ? 0 : null,
                                    decoration: cardDecoration(),
                                    padding: generalPadding,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: TextHighlight(
                                            text: controller.lastWords,
                                            words:
                                                controller.recorder.wrongWords,
                                            textStyle:
                                                textStyle16Black.copyWith(
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                        generalSmallBox,
                                        AnimatedSize(
                                          duration: 200.milliseconds,
                                          child: AnimatedContainer(
                                            duration: 200.milliseconds,
                                            decoration: circleDecoration(
                                              color: controller.isRecording
                                                  ? AppColors.primary
                                                  : controller.isCorrectAnswer
                                                      ? Colors.green
                                                      : Colors.red,
                                            ),
                                            padding: const EdgeInsets.all(2),
                                            child: AnimatedSwitcher(
                                              duration: 200.milliseconds,
                                              transitionBuilder:
                                                  (child, animation) {
                                                return ScaleTransition(
                                                  scale: animation,
                                                  child: child,
                                                );
                                              },
                                              child: Icon(
                                                controller.isRecording
                                                    ? CupertinoIcons.mic_fill
                                                    : controller.isCorrectAnswer
                                                        ? CupertinoIcons
                                                            .check_mark
                                                        : CupertinoIcons.xmark,
                                                color: Colors.white,
                                                key: Key(controller.isRecording
                                                    ? 'ss'
                                                    : 'nn'),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              generalBox,
                              ClipRRect(
                                borderRadius: generalRadius,
                                child: AnimatedSize(
                                  duration: 200.milliseconds,
                                  child: Container(
                                    height: controller
                                                .recorder.missedWords.isEmpty ||
                                            controller.isRecording
                                        ? 0
                                        : null,
                                    decoration: cardDecoration(),
                                    padding: generalPadding,
                                    width: kDeviceWidth,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Missed Words:',
                                          style: textStyle16BlackBold.copyWith(
                                              color: Colors.red),
                                        ),
                                        //generalSmallBox,
                                        Column(
                                          children: [
                                            ...controller
                                                .recorder.missedWords.keys
                                                .map(
                                              (e) => Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '$e: ',
                                                    style: textStyle16Black
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      controller.recorder
                                                          .missedWords[e],
                                                      style: textStyle16Black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: 400.milliseconds,
                  curve: Curves.easeInOutBack,
                  bottom: controller.inputPosition == null
                      ? 0
                      : kDeviceHeight - controller.inputPosition!.dy,
                  // width: kDeviceWidth,
                  // left: horizontalSpacing,
                  // right: horizontalSpacing,
                  child: AnimatedSize(
                    duration: 400.milliseconds,
                    //scale: controller.translation.isNotEmpty ? 1 : 0,
                    curve: Curves.easeInOutBack,
                    child: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        width: kDeviceWidth,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalSpacing),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: SvgPicture.asset(
                                    Assets.assetsIconsDialog,
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.darkPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                AnimatedSize(
                                  duration: 400.milliseconds,
                                  //scale: controller.translation.isNotEmpty ? 1 : 0,
                                  curve: Curves.easeInOutBack,
                                  child: Container(
                                    height: controller.translation.isNotEmpty
                                        ? null
                                        : 0,
                                    width: controller.translation.isNotEmpty
                                        ? kDeviceWidth - horizontalSpacing * 2
                                        : 0,
                                    // decoration: cardDecoration(),
                                    key: controller.translationKey,
                                    padding: controller.translation.isNotEmpty
                                        ? generalPadding
                                        : EdgeInsets.zero,
                                    margin: controller.translation.isNotEmpty
                                        ? EdgeInsets.only(
                                            bottom: verticalSpacing,
                                          )
                                        : EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            controller.translation,
                                            textAlign: TextAlign.center,
                                            style: textStyle14White,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.translation = '';
                                            controller.update();
                                          },
                                          child: AnimatedScale(
                                            duration: 900.milliseconds,
                                            curve: Curves.easeInOutBack,
                                            scale:
                                                controller.translation.isEmpty
                                                    ? 0
                                                    : 1,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: verticalSpacing,
                                              ),
                                              color: Colors.transparent,
                                              child: Icon(
                                                CupertinoIcons.xmark,
                                                size: horizontalSpacing,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: AnimatedScale(
                    duration: 400.milliseconds,
                    scale: MediaQuery.of(context).viewInsets.bottom <
                            verticalSpacing * 6
                        ? 1
                        : 0,
                    curve: Curves.easeOutBack,
                    child: AvatarGlow(
                      endRadius: horizontalSpacing * 4,
                      repeat: true,
                      shape: BoxShape.circle,
                      animate: controller.isRecording,
                      glowColor: AppColors.white,
                      child: GestureDetector(
                        onTap: controller.record,
                        child: Container(
                          decoration: circleDecoration(
                            color: const Color(0xff125E68),
                          ).copyWith(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 2),
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(horizontalSpacing),
                          child: controller.loadingMic
                              ? CupertinoActivityIndicator(
                                  color: AppColors.white,
                                  radius: horizontalSpacing * 1.8 / 2,
                                )
                              : Icon(
                                  controller.isRecording
                                      ? CupertinoIcons.mic_fill
                                      : CupertinoIcons.mic,
                                  color: AppColors.white,
                                  size: horizontalSpacing * 1.8,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CIconButton extends StatelessWidget {
  const CIconButton({
    super.key,
    this.onPress,
    this.icon,
  });
  final Function()? onPress;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing / 2,
        ),
        color: Colors.transparent,
        child: icon is IconData
            ? Icon(
                icon ?? Icons.fiber_manual_record_sharp,
                color: AppColors.primaryDark,
              )
            : SvgPicture.asset(
                icon ?? Assets.assetsIconsRecord,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryDark,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}

/// Draft
/// 
/// 
/// Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     CupertinoButton(
                              //       child: AnimatedContainer(
                              //         duration: 200.milliseconds,
                              //         decoration: cardDecoration(
                              //           color: controller.isRecording
                              //               ? AppColors.primary
                              //               : AppColors.white,
                              //         ),
                              //         padding: generalPadding,
                              //         width: horizontalSpacing * 8,
                              //         child: Row(
                              //           children: [
                              //             AnimatedSwitcher(
                              //               duration: 200.milliseconds,
                              //               child: Icon(
                              //                 color: controller.isRecording
                              //                     ? AppColors.white
                              //                     : AppColors.primary,
                              //                 key: Key(controller.isRecording
                              //                     ? 'y'
                              //                     : 'n'),
                              //                 controller.isRecording
                              //                     ? CupertinoIcons.mic_fill
                              //                     : CupertinoIcons.mic,
                              //                 //  color: AppColors.white,
                              //               ),
                              //             ),
                              //             generalSmallBox,
                              //             Expanded(
                              //               child: AnimatedSwitcher(
                              //                 duration: 200.milliseconds,
                              //                 transitionBuilder:
                              //                     (child, animation) {
                              //                   return ScaleTransition(
                              //                     scale: animation,
                              //                     child: child,
                              //                   );
                              //                 },
                              //                 child: Align(
                              //                   key: Key(
                              //                     controller.isRecording
                              //                         ? 'yes'
                              //                         : 'no',
                              //                   ),
                              //                   child: Text(
                              //                     controller.isRecording
                              //                         ? 'Stop'
                              //                         : 'Record',
                              //                     style: controller.isRecording
                              //                         ? textStyle16White
                              //                         : textStyle16PrimaryBold(),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       onPressed: () {
                              //         controller.record();
                              //       },
                              //     ),
                              //   ],
                              // ),
                              // generalBox,
