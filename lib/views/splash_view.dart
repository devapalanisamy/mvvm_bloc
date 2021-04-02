import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashView());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
