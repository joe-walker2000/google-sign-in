import 'package:auth_test/models/entites.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin _fbLogin = FacebookLogin();

  // auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email & pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // registar with email & pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // creat a new documnet for the user with the uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> onGoogleSignIn() async {
    FirebaseUser user;

    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await _auth.signInWithCredential(credential)).user;
    }
    print(_userFromFirebaseUser(user));

    return _userFromFirebaseUser(user);
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //sign in with facebook
  Future<User> fbSignIn() async {
    FirebaseUser user;
    final FacebookLoginResult facebookLoginResult =
        await _fbLogin.logIn(['email', 'public_profile']);
    FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
    AuthCredential authCredential = FacebookAuthProvider.getCredential(
        accessToken: facebookAccessToken.token);
    user = (await _auth.signInWithCredential(authCredential)).user;

    return _userFromFirebaseUser(user);
  }

  // sign out
  Future signOut() async {
    try {
      bool isSignedIn = await _googleSignIn.isSignedIn();
      if (isSignedIn) {
        _googleSignIn.signOut();
      }
      return await _auth.signOut();

      //return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
