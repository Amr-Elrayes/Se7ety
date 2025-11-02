import 'package:flutter/material.dart';
import 'package:sa7ety/core/constants/app_images.dart';
import 'package:sa7ety/core/routes/navigation.dart';
import 'package:sa7ety/core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // var userData = SharedPref.getUserData();
    Future.delayed(Duration(seconds: 3), () {
      pushReplacment(context, Routes.onboarding);
      // if (userData != null) {
      //   pushReplacment(context, Routes.welcome);
      // } else {
      //   pushReplacment(context, Routes.welcome);
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo , width: 200,),
          ],
        ),
      ),
    );
  }
}
