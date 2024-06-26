import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/json/loading.json',
      fit: BoxFit.fill,
    );
  }
}
