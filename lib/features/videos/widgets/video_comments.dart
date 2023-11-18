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
  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  Color bgColor = Colors.grey.shade50;
  Color mainTextColor = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
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
        body: ListView.separated(
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
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey.shade400,
                radius: 18,
                child: const FaIcon(FontAwesomeIcons.solidUser),
              ),
              const Expanded(child: TextField())
            ],
          ),
        ),
      ),
    );
  }
}
