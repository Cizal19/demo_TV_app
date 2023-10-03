import 'package:flutter/material.dart';

class CustomFocus extends StatelessWidget {
  const CustomFocus({
    super.key,
    required FocusNode? iconFocusNode,
    required this.child,
  }) : _icon1FocusNode = iconFocusNode;

  final FocusNode? _icon1FocusNode;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _icon1FocusNode,
      child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: !(_icon1FocusNode?.hasFocus ?? false)
                  ? null
                  : Border.all(width: 5, color: Color(0xffeb1555))),
          child: child),
    );
  }
}
