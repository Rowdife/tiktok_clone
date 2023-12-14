import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isSelfieMode = false;

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

    _flashMode = _cameraController.value.flashMode;
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
    initPermissions();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _deniedPermission
          ? const Center(
              child: Text(
                  "You denied camera or microphone permission. If you want to use this function, you have to change permission from settings."),
            )
          : !_hasPermission || !_cameraController.value.isInitialized
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
                    children: [
                      CameraPreview(_cameraController),
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
                              onPressed: () => _setFlashMode(FlashMode.always),
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
                              onPressed: () => _setFlashMode(FlashMode.torch),
                              icon: const Icon(Icons.flashlight_on_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
