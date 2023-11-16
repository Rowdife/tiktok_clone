import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final int index;

  const VideoPost({
    super.key,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;

  late final AnimationController _animationController;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  final int _captionLengthLimit = 65;

  final TextStyle _textButton = const TextStyle(color: Colors.white60);

  bool _isPaused = false;

  bool _isFullCaptionShowed = false;

  final String _captionText =
      "This is my golf swing. This is my golf swing. This is my golf swing. This is my golf swing. This is my golf swing. This is my golf swing. This is my golf swing. This is my golf swing. This is my golf swing.";

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/IMG_2127.MOV");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.0,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // Now the display shows 100% fraction and video is not playing, then play the video.
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      _videoPlayerController.play();
    }
  }

  void _togglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      setState(() {
        _isPaused = true;
      });
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      setState(() {
        _isPaused = false;
      });
      _animationController.forward();
    }
  }

  void _toggleMoreAndClose() {
    setState(() {
      _isFullCaptionShowed = !_isFullCaptionShowed;
    });
  }

  String _autoEditedCaptionText() {
    if (_captionText.length > _captionLengthLimit) {
      return "${_captionText.substring(0, _captionLengthLimit)}...";
    } else {
      return _captionText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      //this child is just from AnimatedBuilder's child which is now, the AnimatedOpacity.
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: Container(
                      width: Sizes.size96,
                      height: Sizes.size96,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black38,
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.play,
                          color: Colors.white,
                          size: Sizes.size52,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: _isFullCaptionShowed
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7), // 반투명 검은색
                          Colors.transparent, // 투명
                        ],
                      ),
                    )
                  : const BoxDecoration(),
              child: const Text(
                '',
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@Shihyun",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                SizedBox(
                  width: 290,
                  child: _captionText.length > _captionLengthLimit
                      ? Text.rich(
                          TextSpan(
                            text: _isFullCaptionShowed
                                ? _captionText
                                : _autoEditedCaptionText(),
                            style: const TextStyle(
                              fontSize: Sizes.size14,
                              color: Colors.white,
                            ),
                            children: [
                              _isFullCaptionShowed
                                  ? TextSpan(
                                      text: "   Close",
                                      style: _textButton,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _toggleMoreAndClose,
                                    )
                                  : TextSpan(
                                      text: "Read more",
                                      style: _textButton,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _toggleMoreAndClose,
                                    )
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: _isFullCaptionShowed ? 999 : 2,
                        )
                      : Text(
                          _captionText,
                          style: const TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/76625609?v=4"),
                  child: FaIcon(
                    FontAwesomeIcons.user,
                  ),
                ),
                Gaps.v20,
                VideoButton(icon: FontAwesomeIcons.solidHeart, label: "2.9M"),
                Gaps.v20,
                VideoButton(
                    icon: FontAwesomeIcons.solidCommentDots, label: "33.0K"),
                Gaps.v20,
                VideoButton(icon: FontAwesomeIcons.share, label: "Share"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
