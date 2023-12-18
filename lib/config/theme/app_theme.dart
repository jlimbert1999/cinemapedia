import 'package:flutter/material.dart';

class AppTheme {
  getTheme() {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent));
  }
}
