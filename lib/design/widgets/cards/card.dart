import 'package:english_pr/design/styles/shapes.dart';
import 'package:english_pr/logic/utils/assets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    Key? key,
    this.alignment = AlignmentDirectional.centerStart,
    required this.title,
    this.onPress,
  }) : super(key: key);
  final AlignmentGeometry alignment;
  final String title;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    double height = kDeviceHeight * 0.15;
    return GestureDetector(
      onTap: onPress,
      child: Align(
        alignment: alignment,
        child: Container(
          margin: generalPadding,
          width: kDeviceWidth * 1,
          height: height,
          decoration: cardDecoration(
            color: AppColors.primary,
          ),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SvgPicture.asset(
                  Assets.assetsIconsPattern,
                  fit: BoxFit.cover,
                  height: height + 20,
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: generalPadding,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
