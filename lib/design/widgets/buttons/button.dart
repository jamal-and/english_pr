import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class CButton extends StatelessWidget {
  const CButton({
    super.key,
    this.onPress,
    this.text,
    this.icon,
  });
  final Function()? onPress;
  final String? text;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPress,
      child: Container(
        decoration: cardDecoration(),
        padding: generalPadding,
        child: Row(
          children: [
            icon is IconData
                ? Icon(
                    icon,
                    //color: AppColors.white,
                  )
                : icon != null
                    ? SvgPicture.asset(icon)
                    : const SizedBox(),
            generalSmallBox,
            Text(
              text ?? 'Click',
              style: textStyle16PrimaryBold(),
            ),
          ],
        ),
      ),
    );
  }
}
