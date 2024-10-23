import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onlineshopwang/allProductlist.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const AllProduct())));
    {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('./lib/assets/logo.png'),
    );
  }
}
