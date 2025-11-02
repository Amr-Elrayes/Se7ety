import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sa7ety/core/routes/routes.dart';
import 'package:sa7ety/core/utils/app_theme.dart';
import 'package:sa7ety/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    Directionality(textDirection: TextDirection.rtl, child: const Se7ety()),
  );
}

class Se7ety extends StatelessWidget {
  const Se7ety({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: Routes.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
