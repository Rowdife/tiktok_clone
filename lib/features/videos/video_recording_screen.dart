import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isSelfieMode = false;
  bool _isDisposed = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late final AnimationController _buttonAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 0.85).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
          vsync: this,
          duration: const Duration(seconds: 10),
          lowerBound: 0.0,
          upperBound: 1.0);
  late FlashMode _flashMode;

  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied = microphonePermission.isDenied ||
        microphonePermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      await initCamera();
      _hasPermission = true;

      setState(() {});
    }

    if (cameraDenied || micDenied) {
      setState(() {
        _deniedPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera) return;
    if (!_cameraController.value.isInitialized || !_hasPermission) return;

    if (state == AppLifecycleState.inactive) {
      _isDisposed = true;
      setState(() {});
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _isDisposed = false;
      initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _deniedPermission
          ? const Center(
              child: Text(
                  "You denied camera or microphone permission. If you want to use this function, you have to change permission from settings."),
            )
          : !_hasPermission
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Requesting permissions..."),
                      Gaps.v20,
                      CircularProgressIndicator.adaptive()
                    ],
                  ),
                )
              : SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!_isDisposed &&
                          !_noCamera &&
                          _cameraController.value.isInitialized)
                        CameraPreview(_cameraController),
                      const Positioned(
                        top: Sizes.size20,
                        left: Sizes.size20,
                        child: CloseButton(
                          color: Colors.white,
                        ),
                      ),
                      if (!_noCamera)
                        Positioned(
                          top: Sizes.size20,
                          right: Sizes.size20,
                          child: Column(
                            children: [
                              IconButton(
                                color: Colors.white,
                                onPressed: _toggleSelfieMode,
                                icon: const Icon(Icons.cameraswitch),
                              ),
                              Gaps.v10,
                              IconButton(
                                color: _flashMode == FlashMode.off
                                    ? Colors.yellow
                                    : Colors.white,
                                onPressed: () => _setFlashMode(FlashMode.off),
                                icon: const Icon(Icons.flash_off_rounded),
                              ),
                              Gaps.v10,
                              IconButton(
                                color: _flashMode == FlashMode.always
                                    ? Colors.yellow
                                    : Colors.white,
                                onPressed: () =>
                                    _setFlashMode(FlashMode.always),
                                icon: const Icon(Icons.flash_on_rounded),
                              ),
                              Gaps.v10,
                              IconButton(
                                color: _flashMode == FlashMode.auto
                                    ? Colors.yellow
                                    : Colors.white,
                                onPressed: () => _setFlashMode(FlashMode.auto),
                                icon: const Icon(Icons.flash_auto_rounded),
                              ),
                              Gaps.v10,
                              IconButton(
                                color: _flashMode == FlashMode.torch
                                    ? Colors.yellow
                                    : Colors.white,
                                onPressed: () async {
                                  if (_isSelfieMode) return;
                                  _setFlashMode(FlashMode.torch);
                                },
                                icon: const Icon(Icons.flashlight_on_rounded),
                              ),
                            ],
                          ),
                        ),
                      Positioned(
                        bottom: Sizes.size40,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTapDown: (details) => _startRecording(),
                              onTapUp: (details) => _stopRecording(),
                              child: ScaleTransition(
                                scale: _buttonAnimation,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: Sizes.size80 + Sizes.size4,
                                      height: Sizes.size80 + Sizes.size4,
                                      child: CircularProgressIndicator(
                                        color: Colors.red.shade400,
                                        value:
                                            _progressAnimationController.value,
                                      ),
                                    ),
                                    Container(
                                      width: Sizes.size80,
                                      height: Sizes.size80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.shade400,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: _onPickVideoPressed,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.image,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
