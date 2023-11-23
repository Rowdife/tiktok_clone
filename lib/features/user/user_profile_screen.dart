import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text("Shihyun"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                size: Sizes.size20,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                foregroundColor: Colors.teal,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/76625609?v=4"),
                child: Text("Shihyun"),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "@Shihyun_Park",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size18,
                    ),
                  ),
                  Gaps.h5,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size16,
                    color: Colors.blue.shade500,
                  )
                ],
              ),
              Gaps.v24,
              SizedBox(
                height: Sizes.size44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "10M",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.v3,
                        Text("Followers"),
                      ],
                    ),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                      color: Colors.grey.shade400,
                    ),
                    const Column(
                      children: [
                        Text(
                          "97",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.v3,
                        Text("Following"),
                      ],
                    ),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                      color: Colors.grey.shade400,
                    ),
                    const Column(
                      children: [
                        Text(
                          "194.3M",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.v3,
                        Text("Likes"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
