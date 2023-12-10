import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool _isWriting = false;

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _onFinishWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 10,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: 25,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/76625609?v=4"),
              ),
              Positioned(
                top: 32,
                left: 32,
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        )),
                  ),
                ),
              )
            ],
          ),
          title: const Text(
            "XXXMMM967",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _onFinishWriting,
        child: Stack(
          children: [
            ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                  horizontal: Sizes.size14,
                ),
                itemBuilder: (context, index) {
                  final isMine = index % 2 == 0;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          Sizes.size14,
                        ),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(Sizes.size20),
                            topRight: const Radius.circular(Sizes.size20),
                            bottomLeft: Radius.circular(
                                isMine ? Sizes.size20 : Sizes.size5),
                            bottomRight: Radius.circular(
                                isMine ? Sizes.size5 : Sizes.size20),
                          ),
                        ),
                        child: const Text(
                          "this is a message!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 10),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                padding: const EdgeInsets.only(
                  left: Sizes.size20,
                  bottom: Sizes.size5,
                  top: Sizes.size5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          onTap: _onStartWriting,
                          keyboardType:
                              TextInputType.multiline, //Doing the same thing
                          textInputAction: TextInputAction.newline,
                          expands: true,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Send a message...",
                            contentPadding: const EdgeInsets.only(
                              left: Sizes.size20,
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!_isWriting)
                                  FaIcon(
                                    FontAwesomeIcons.faceLaugh,
                                    color: isDarkMode(context)
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                              ],
                            ),
                            filled: true,
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Sizes.size24),
                                  topLeft: Radius.circular(Sizes.size24),
                                  bottomLeft: Radius.circular(Sizes.size24),
                                ),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h20,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                          right: Sizes.size20,
                        ),
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                _isWriting ? Colors.blue : Colors.grey.shade400,
                            child: const FaIcon(
                              FontAwesomeIcons.solidPaperPlane,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
