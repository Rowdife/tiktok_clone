import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/user/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/user/widgets/avatar.dart';
import 'package:tiktok_clone/features/user/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (cotext) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onGearPressed,
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
                            Avatar(
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                              uid: data.uid,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
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
                              height: Sizes.size52,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "10M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v3,
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    indent: Sizes.size12,
                                    endIndent: Sizes.size12,
                                    color: Colors.grey.shade400,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "97",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v3,
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    indent: Sizes.size12,
                                    endIndent: Sizes.size12,
                                    color: Colors.grey.shade400,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "194.3M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v3,
                                      Text(
                                        "Likes",
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: Sizes.size52,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size2),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Follow",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.h4,
                                Container(
                                  height: Sizes.size52,
                                  width: Sizes.size52,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size2),
                                    ),
                                  ),
                                  child: const Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.youtube,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                Gaps.h4,
                                Container(
                                  height: Sizes.size52,
                                  width: Sizes.size52,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size14,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size2),
                                    ),
                                  ),
                                  child: Center(
                                    child: Transform.rotate(
                                        angle: 90 * (3.141592653589793 / 180),
                                        child: const FaIcon(
                                          FontAwesomeIcons.play,
                                          size: Sizes.size10,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size40,
                              ),
                              child: Text(
                                "All highlights and where to watch live matches on FIFA+ I wonder how it would lookfdsafdsasadsafafsdfdsafsda",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  data.link,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 14,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 14,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.fitHeight,
                                    placeholder:
                                        "assets/images/placeholder.jpg",
                                    image:
                                        "https://cdn.pixabay.com/photo/2016/11/29/04/19/ocean-1867285_1280.jpg",
                                  ),
                                ),
                                const Positioned(
                                  left: -2,
                                  bottom: 0,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.play_arrow_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "4.1M",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Sizes.size12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("Page two"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
