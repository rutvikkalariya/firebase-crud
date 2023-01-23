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
    apiKey: 'AIzaSyB0SLP6PWHbgIYZ-y0P1tOFV9ZRpFuMdIw',
    appId: '1:1063570279187:web:ca03da2623c46daf5d68e6',
    messagingSenderId: '1063570279187',
    projectId: 'fir-crud-new-4952c',
    authDomain: 'fir-crud-new-4952c.firebaseapp.com',
    storageBucket: 'fir-crud-new-4952c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAZ4jjFu-e1LBKmzhq1WMyTJ3uKz2fL2c',
    appId: '1:1063570279187:android:271a17b8ff07e6d55d68e6',
    messagingSenderId: '1063570279187',
    projectId: 'fir-crud-new-4952c',
    storageBucket: 'fir-crud-new-4952c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxl2t0_JEIpbq9W5q_ywqiwueiv15C47s',
    appId: '1:1063570279187:ios:2c6499e0ba45cf405d68e6',
    messagingSenderId: '1063570279187',
    projectId: 'fir-crud-new-4952c',
    storageBucket: 'fir-crud-new-4952c.appspot.com',
    iosClientId: '1063570279187-3evhcnnuv1jqfhakdq6kpnhc8efe4lvt.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseCrud',
  );
}