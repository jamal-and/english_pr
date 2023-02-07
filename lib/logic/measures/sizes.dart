import 'dart:ui';

double pixelRatio = window.devicePixelRatio;

/// Size in physical pixels
Size physicalScreenSize = window.physicalSize;
double physicalWidth = physicalScreenSize.width;
double physicalHeight = physicalScreenSize.height;

/// Size in logical pixels
Size logicalScreenSize = window.physicalSize / pixelRatio;
final double screenRatio = (logicalScreenSize.height / logicalScreenSize.width);
// ignore: avoid_bool_literals_in_conditional_expressions
bool isThereSystemNav = screenRatio < 19.1 / 9 ? true : false;
double heightToBeAdded() {
  if (screenRatio >= 2.16) {
    return 0;
  } else {
    final double newSize = 2.16 * kDeviceWidth;
    return newSize - logicalScreenSize.height;
  }
}

///  ignore: duplicate_ignore
double kDeviceWidth = logicalScreenSize.width;
double kDeviceHeight = logicalScreenSize.height;
double kResponsiveHeight = (isThereSystemNav)
    ? logicalScreenSize.height + heightToBeAdded()
    : logicalScreenSize.height;
