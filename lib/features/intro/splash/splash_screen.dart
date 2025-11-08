import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa7ety/core/constants/app_images.dart';
import 'package:sa7ety/core/routes/navigation.dart';
import 'package:sa7ety/core/routes/routes.dart';
import 'package:sa7ety/services/local/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool seen = SharedPref.isOnboardingSeen();
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration(seconds: 3), () {
      if (user != null) {
        if (user.photoURL == "doctor") {
          pushReplacment(context, Routes.doctor_main);
        } else {
          pushReplacment(context, Routes.patent_main);
        }
      } else {
        if (seen) {
          pushReplacment(context, Routes.welcome);
        } else {
          pushReplacment(context, Routes.onboarding);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(AppImages.logo, width: 200)],
        ),
      ),
    );
  }
}
