// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD2MIgFscOAU5bpHRmq4jqVsBGLWD8Tz7s',
    appId: '1:309180149242:web:195af64cf7375992f1c843',
    messagingSenderId: '309180149242',
    projectId: 'tiktok-clone-nooomad',
    authDomain: 'tiktok-clone-nooomad.firebaseapp.com',
    storageBucket: 'tiktok-clone-nooomad.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXQRvLjwc77PDu6hzhWsXf044m3n3UTaU',
    appId: '1:309180149242:android:48bfe160522231bdf1c843',
    messagingSenderId: '309180149242',
    projectId: 'tiktok-clone-nooomad',
    storageBucket: 'tiktok-clone-nooomad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBT3evXEk9u9LMDBj0XMmlY73rDkclkUfE',
    appId: '1:309180149242:ios:31acc589f6998ceaf1c843',
    messagingSenderId: '309180149242',
    projectId: 'tiktok-clone-nooomad',
    storageBucket: 'tiktok-clone-nooomad.appspot.com',
    iosBundleId: 'com.example.fdjslkajfoida2313124',
  );
}
