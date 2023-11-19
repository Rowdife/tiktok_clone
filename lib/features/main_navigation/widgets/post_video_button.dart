import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    super.key,
    required this.inverted,
  });

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 22,
          child: Container(
            height: 28,
            width: Sizes.size28,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffE7426E),
              borderRadius: BorderRadius.circular(
                Sizes.size11,
              ),
            ),
          ),
        ),
        Positioned(
          right: 22,
          child: Container(
            height: 28,
            width: Sizes.size28,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff68D2E8),
              borderRadius: BorderRadius.circular(
                Sizes.size11,
              ),
            ),
          ),
        ),
        Container(
          height: 28,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
          ),
          decoration: BoxDecoration(
            color: inverted ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size11),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: inverted ? Colors.white : Colors.black,
              size: Sizes.size24,
            ),
          ),
        ),
      ],
    );
  }
}
