import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

class AuthService {
  static String usertoken = "";
  final _auth = FirebaseAuth.instance;
  bool flag = false;
  final _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        usertoken = googleSignInAuthentication.idToken!;
        // Print the ID Token
        log('ID Token: ${googleSignInAuthentication.idToken}');
        print('acc Token: ${googleSignInAuthentication.accessToken}');
        flag = true;
        final UserCredential userCredential =
            await _auth.signInWithCredential(authCredential);
        return userCredential
            .user; // Ensure to import User from 'package:firebase_auth/firebase_auth.dart'
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
    return null;
  }

  Future<void> googleSignOut() async {
    try {
      // Sign out from Google Sign-In
      // await _googleSignIn.disconnect();
      await _googleSignIn.signOut();

      // Sign out from the general authentication system (_auth)
      await _auth.signOut();
    } catch (e) {
      // Handle any errors that might occur during the sign-out process
      print("Error during sign-out: $e");
      // You can add additional error handling or display a user-friendly message if needed
    }
  }
}
