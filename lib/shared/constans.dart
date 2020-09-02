import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintText: 'Email',
  fillColor: Colors.white,
  suffixIcon: Icon(Icons.email),
  filled: false,

  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
);
