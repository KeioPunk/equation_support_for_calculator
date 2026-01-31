import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-X_Placeholder', // Firebase Studio täidab selle ise
    appId: '1:7884903030:android:650d...', // Su pildilt pärit ID
    messagingSenderId: '7884903030',
    projectId: 'hulkapp-4cb9b', // Sinu HulkApp projekt!
    storageBucket: 'hulkapp-4cb9b.appspot.com',
  );
}