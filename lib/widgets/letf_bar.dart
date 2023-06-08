import 'package:flutter/cupertino.dart';

import 'package:bmi_calculator/constants/app_constants.dart';

class LeftBar extends StatelessWidget {
  final double barwidth;
  const LeftBar({super.key, required this.barwidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 25,
          width: barwidth,
          decoration: BoxDecoration(
            color: accentHexColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        )
      ],
    );
  }
}
