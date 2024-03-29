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
// ...
// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // case TargetPlatform.macOS:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for macos - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      // case TargetPlatform.windows:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for windows - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      // case TargetPlatform.linux:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for linux - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfuwSUIW3k9A0MWy9TTpTgeOcbYrsTH8E',
    appId: '1:491622402812:android:53f00443eb6840fbca6579',
    messagingSenderId: '491622402812',
    projectId: 'poloniex-omla-test',
    storageBucket: 'poloniex-omla-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDIyzFFlr5x-_ReLQJkJXrNYhTStuJ5c0',
    appId: '1:491622402812:ios:d142b247eb5ab2a0ca6579',
    messagingSenderId: '491622402812',
    projectId: 'poloniex-omla-test',
    storageBucket: 'poloniex-omla-test.appspot.com',
    iosBundleId: 'com.example.poloniexTest',
  );
}
