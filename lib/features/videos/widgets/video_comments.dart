import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  void _unfocusKeyboard() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(Sizes.size14)),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            S.of(context).commentTitle(1, 1),
          ),
          actions: [
            IconButton(
              onPressed: _onClosedPressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _unfocusKeyboard,
          child: Stack(
            children: [
              Scrollbar(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                      top: Sizes.size10,
                      right: Sizes.size10,
                      left: Sizes.size16,
                      bottom: Sizes.size96 + Sizes.size10),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        child: FaIcon(FontAwesomeIcons.solidUser),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shihyun",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                              ),
                            ),
                            Gaps.v4,
                            Text(
                                "This is my golf swing. This is my golf swing. This is my golf swing. This is my golf swing. ")
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                          ),
                          Gaps.v4,
                          Text(
                            "31.9K",
                            style: TextStyle(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: Container(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: Sizes.size24, top: Sizes.size8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.size16),
                          child: CircleAvatar(
                            radius: 18,
                            child: FaIcon(FontAwesomeIcons.solidUser),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 36,
                            child: TextField(
                              onTap: _onStartWriting,
                              expands: true,
                              keyboardType: TextInputType
                                  .multiline, //Doing the same thing
                              textInputAction: TextInputAction
                                  .newline, //Doing the same thing
                              minLines: null,
                              maxLines: null,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Write a comment.",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size16,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (!_isWriting)
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.at,
                                              color: isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                              size: Sizes.size20,
                                            ),
                                            Gaps.h8,
                                            FaIcon(
                                              FontAwesomeIcons.gift,
                                              color: isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                              size: Sizes.size20,
                                            ),
                                            Gaps.h8,
                                            FaIcon(
                                              FontAwesomeIcons.faceSmile,
                                              color: isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                              size: Sizes.size20,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gaps.h10,
                        if (_isWriting)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              onPressed: _unfocusKeyboard,
                              icon: FaIcon(
                                FontAwesomeIcons.paperPlane,
                                color: Theme.of(context).primaryColor,
                                size: Sizes.size20,
                              ),
                            ),
                          )
                      ],
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
