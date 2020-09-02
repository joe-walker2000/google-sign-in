import 'package:auth_test/models/entites.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'authenticate/Authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
