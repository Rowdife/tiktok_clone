import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/widgets/video_config/darkmode_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class NavTab extends StatefulWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;

  @override
  State<NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<NavTab> {
  bool _isDarkMode = darkmodeConfig.value;

  @override
  void initState() {
    super.initState();
    darkmodeConfig.addListener(() {
      setState(() {
        _isDarkMode = darkmodeConfig.value;
      });
    });
  }

  @override
  void dispose() {
    darkmodeConfig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => widget.onTap(),
        child: Container(
          color: _isDarkMode ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            opacity: widget.isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  widget.isSelected ? widget.selectedIcon : widget.icon,
                  color: _isDarkMode ? Colors.white : Colors.black,
                  size: Sizes.size16,
                ),
                Gaps.v5,
                Text(
                  widget.text,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontSize: Sizes.size12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
