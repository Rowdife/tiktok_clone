import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  Color bgColor = Colors.grey.shade50;
  Color mainTextColor = Colors.grey.shade600;

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
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          automaticallyImplyLeading: false,
          title: const Text("22796 comments"),
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
              ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                  horizontal: Sizes.size16,
                ),
                separatorBuilder: (context, index) => Gaps.v20,
                itemCount: 10,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
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
                              color: mainTextColor,
                            ),
                          ),
                          Gaps.v4,
                          const Text(
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
                          color: mainTextColor,
                        ),
                        Gaps.v4,
                        Text(
                          "31.9K",
                          style: TextStyle(
                            color: mainTextColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size16),
                          child: CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey.shade400,
                            radius: 18,
                            child: const FaIcon(FontAwesomeIcons.solidUser),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
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
                                fillColor: Colors.grey.shade200,
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
                                      if (!_isWriting)
                                        const Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.at,
                                              color: Colors.black,
                                              size: Sizes.size20,
                                            ),
                                            Gaps.h8,
                                            FaIcon(
                                              FontAwesomeIcons.gift,
                                              color: Colors.black,
                                              size: Sizes.size20,
                                            ),
                                            Gaps.h8,
                                            FaIcon(
                                              FontAwesomeIcons.faceSmile,
                                              color: Colors.black,
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
                              icon: FaIcon(FontAwesomeIcons.paperPlane,
                                  color: Theme.of(context).primaryColor),
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
