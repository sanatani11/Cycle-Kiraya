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
        return macos;
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
    apiKey: 'AIzaSyBfnqIhYyDZx2ZEOY6DGR8S4GVy0Mj5k5w',
    appId: '1:758489623121:web:38d92c34750d7b5979a670',
    messagingSenderId: '758489623121',
    projectId: 'cycle-kiraya',
    authDomain: 'cycle-kiraya.firebaseapp.com',
    storageBucket: 'cycle-kiraya.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEX3e0qLU-ved-16OXS09x_n1cqOpVHno',
    appId: '1:758489623121:android:bb05858ddac2349b79a670',
    messagingSenderId: '758489623121',
    projectId: 'cycle-kiraya',
    storageBucket: 'cycle-kiraya.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAljvjWNxC1YnodSJCCHN_X9SvlvhixMBk',
    appId: '1:758489623121:ios:881ec7b6985175ee79a670',
    messagingSenderId: '758489623121',
    projectId: 'cycle-kiraya',
    storageBucket: 'cycle-kiraya.appspot.com',
    iosBundleId: 'com.example.cycleKiraya',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAljvjWNxC1YnodSJCCHN_X9SvlvhixMBk',
    appId: '1:758489623121:ios:22b86cdd1438c51679a670',
    messagingSenderId: '758489623121',
    projectId: 'cycle-kiraya',
    storageBucket: 'cycle-kiraya.appspot.com',
    iosBundleId: 'com.example.cycleKiraya.RunnerTests',
  );
}