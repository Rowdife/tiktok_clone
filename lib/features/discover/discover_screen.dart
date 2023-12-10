import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "Live",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isWriting = false;

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  void _unfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onUnfocusByTap(VisibilityInfo info) {
    _unfocusKeyboard();
  }

  void _onClearTap() {
    _textEditingController.clear();
  }

  void _textFieldCheck() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        _isWriting = true;
      });
    } else {
      setState(() {
        _isWriting = false;
      });
    }
  }

  @override
  void initState() {
    _textEditingController.addListener(_textFieldCheck);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.5,
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: TextField(
              controller: _textEditingController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: isDarkMode(context) ? Colors.grey : Colors.black,
                    ),
                  ],
                ),
                hintText: "Write a comment.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Sizes.size4),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    right: Sizes.size14,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isWriting)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _onClearTap,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                color: Colors.grey.shade500,
                                size: Sizes.size20,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            splashFactory: NoSplash.splashFactory,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: Sizes.size16),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GestureDetector(
              onTap: _unfocusKeyboard,
              child: GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: const EdgeInsets.all(Sizes.size6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 20,
                ),
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.fitHeight,
                            placeholder: "assets/images/placeholder.jpg",
                            image:
                                "https://cdn.pixabay.com/photo/2016/11/29/04/19/ocean-1867285_1280.jpg",
                          ),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "This is a very long caption for my tiktok that I'm upload just for now.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v8,
                      if (constraints.maxWidth < 198 ||
                          constraints.maxWidth > 262)
                        DefaultTextStyle(
                          style: TextStyle(
                              color: isDarkMode(context)
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                              fontSize: Sizes.size12,
                              fontWeight: FontWeight.w600),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/76625609?v=4"),
                              ),
                              Gaps.h4,
                              const Expanded(
                                child: Text(
                                  "My namfdsafsalkdfsaf;lsafjksf;lsal",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Gaps.h4,
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size14,
                                color: Colors.grey.shade700,
                              ),
                              Gaps.h2,
                              const Text(
                                "2.2M",
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              VisibilityDetector(
                key: Key(tab),
                onVisibilityChanged: _onUnfocusByTap,
                child: Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size28,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
