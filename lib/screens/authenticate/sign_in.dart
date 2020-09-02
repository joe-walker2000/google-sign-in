import 'package:auth_test/services/auth.dart';
import 'package:auth_test/shared/constans.dart';
import 'package:auth_test/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  Future signInWithEmail() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      if (result == null) {
        setState(() {
          error = 'COULD NOT SIGN IN WITH THOSE credentials';
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.blue[700],
              elevation: 0.0,
              title: Text('Sign in'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              //color: Colors.yellow,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red],
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Password', suffixIcon: Icon(Icons.lock)),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 40.0),
                      _buildButtonWidget('Sign In With Email', signInWithEmail),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                        height: 50,
                      ),
                      _buildButtonWidget('Sign In With Google', () async {
                        _auth.onGoogleSignIn();
                      }),
                      SizedBox(height: 20),
                      _buildButtonWidget('Sign In With Facebook', () async {
                        _auth.fbSignIn();
                      }),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

_buildButtonWidget(String text, Function onPressed) {
  return RaisedButton(
    elevation: 10,
    onPressed: onPressed,
    textColor: Colors.white,
    padding: const EdgeInsets.all(0.0),
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.yellow],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.email),
              SizedBox(
                width: 50,
              ),
              Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
