import 'package:auth_test/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('You are at home'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  _auth.signOut();
                },
                icon: Icon(Icons.exit_to_app),
                label: Text('Sign Out'))
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red],
            ),
          ),
          child: Center(
            child: FloatingActionButton(
              onPressed: () {
                _auth.signOut();
              },
            ),
          ),
        ));
  }
}
