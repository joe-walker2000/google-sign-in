import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';

class WelcomeUserWidget extends StatelessWidget {
  GoogleSignIn _googleSignIn;
  User _user;
  WelcomeUserWidget(User user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signed in Using Google'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                _googleSignIn.signOut();
                Navigator.pop(context);
              },
              child: Text('you are logged in With Google'),
            )
          ],
        ),
      ),
    );
  }
}
