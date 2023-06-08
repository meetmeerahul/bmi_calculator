import 'package:flutter/cupertino.dart';

import 'package:bmi_calculator/constants/app_constants.dart';

class RightBAr extends StatelessWidget {
  final double barwidth;
  const RightBAr({super.key, required this.barwidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 25,
          width: barwidth,
          decoration: BoxDecoration(
            color: accentHexColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        )
      ],
    );
  }
}
