// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyANS7603ME6tUx2BW7vnqqg8ekCK7FkFwo',
    appId: '1:593007828996:web:08b8a27706523632471551',
    messagingSenderId: '593007828996',
    projectId: 'gasbygas-3ed1c',
    authDomain: 'gasbygas-3ed1c.firebaseapp.com',
    storageBucket: 'gasbygas-3ed1c.firebasestorage.app',
    measurementId: 'G-C38VVE5T6J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwNKLa0Bn1IkukvhS5qyWDbnrdamPmU00',
    appId: '1:593007828996:android:563f2879fa1c386a471551',
    messagingSenderId: '593007828996',
    projectId: 'gasbygas-3ed1c',
    storageBucket: 'gasbygas-3ed1c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5beV3rbDVz-I8eSuzo5cJEbZKPOc-0R0',
    appId: '1:593007828996:ios:e1d70d578b1e767b471551',
    messagingSenderId: '593007828996',
    projectId: 'gasbygas-3ed1c',
    storageBucket: 'gasbygas-3ed1c.firebasestorage.app',
    iosBundleId: 'com.example.gasByGas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5beV3rbDVz-I8eSuzo5cJEbZKPOc-0R0',
    appId: '1:593007828996:ios:e1d70d578b1e767b471551',
    messagingSenderId: '593007828996',
    projectId: 'gasbygas-3ed1c',
    storageBucket: 'gasbygas-3ed1c.firebasestorage.app',
    iosBundleId: 'com.example.gasByGas',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyANS7603ME6tUx2BW7vnqqg8ekCK7FkFwo',
    appId: '1:593007828996:web:c131f72ca780aef4471551',
    messagingSenderId: '593007828996',
    projectId: 'gasbygas-3ed1c',
    authDomain: 'gasbygas-3ed1c.firebaseapp.com',
    storageBucket: 'gasbygas-3ed1c.firebasestorage.app',
    measurementId: 'G-SYR44LMCZB',
  );
}
