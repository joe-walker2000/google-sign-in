import 'package:auth_test/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
class User{
  final String uid;
  User({this.uid});
}


class MyHomePage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  Future<User> _handleSignIn() async {
    // hold the instance of the authenticated user
    // ignore: deprecated_member_use
    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      //user = await _auth.currentUser();
    }
    else {
      final GoogleSignInAccount googleUser =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential =
      GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      user = (await _auth.signInWithCredential(credential)).user;
    }

    return _userFromFirebaseUser(user);
  }
  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WelcomeUserWidget(user, _googleSignIn)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In Using Google'),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: (){
                onGoogleSignIn(context);
              },
              child: Text('Sign In With Google'),
            )
          ],
        ),
      ),
    );
  }
}
