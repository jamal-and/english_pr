import '../../../general_exports.dart';

// General Spacing

final double horizontalSpacing = kDeviceWidth * 0.05;
final double verticalSpacing = kDeviceHeight * 0.02;

// Widgets Measures

final double fullWidthButtonHeight = kDeviceHeight * 0.065;
final double shaderHeight = kDeviceHeight * 0.75;

final generalPadding = EdgeInsets.symmetric(
  vertical: verticalSpacing,
  horizontal: horizontalSpacing,
);

final inputPadding = EdgeInsets.symmetric(
  vertical: verticalSpacing / 2,
  horizontal: horizontalSpacing,
);

const Duration generalDuration = Duration(milliseconds: 400);

final generalRadius = BorderRadius.circular(horizontalSpacing);
