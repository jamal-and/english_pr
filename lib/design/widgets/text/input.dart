import '../../../general_exports.dart';

class CTextInput extends StatelessWidget {
  const CTextInput({
    super.key,
    required this.onChange,
    required this.controller,
    this.minLines,
    this.maxLines,
    this.hint,
    this.enable = true,
    this.bottom,
  });
  final Function(String v) onChange;
  final TextEditingController controller;
  final int? minLines;
  final int? maxLines;
  final String? hint;
  final bool enable;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Padding(
            padding: generalPadding,
            child: TextField(
              controller: controller,
              enabled: enable,
              maxLines: maxLines,
              minLines: minLines,
              onChanged: onChange,
              decoration: InputDecoration.collapsed(
                hintText: hint,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          bottom ?? const SizedBox(),
        ],
      ),
    );
  }
}
