// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sa7ety/features/auth/models/user_type_enum.dart';
import 'package:sa7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sa7ety/features/auth/presentation/screens/doctor_regestration.dart';
import 'package:sa7ety/features/auth/presentation/screens/login_screen.dart';
import 'package:sa7ety/features/auth/presentation/screens/register_screen.dart';
import 'package:sa7ety/features/main/main_app_screen.dart';
import 'package:sa7ety/features/onboarding/onboarding_screen.dart';
import 'package:sa7ety/features/splash/splash_screen.dart';
import 'package:sa7ety/features/welcome/welcome_screen.dart';

class Routes {
  static String splah = "/";
  static String onboarding = "/onboarding";
  static String welcome = "/welcome";
  static String login = "/login";
  static String register = "/register";
  static String docregister = "/docregister";
  static String main = "/main";

  static GoRouter routes = GoRouter(
    routes: [
      GoRoute(path: splah, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) {
          final userType = state.extra as usertype;
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginScreen(userType: userType),
          );
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          final userType = state.extra as usertype;
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: RegisterScreen(userType: userType),
          );
        },
      ),
      GoRoute(
        path: docregister,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: DoctorRegestration(),
          );
        },
      ),
      GoRoute(
        path: main,
        builder: (context, state) {
          return MainAppScreen();
        },
      ),
    ],
  );
}
