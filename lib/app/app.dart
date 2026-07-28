import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import '../features/auth/presentation/login/login_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

class NutriHubApp extends StatelessWidget {
  const NutriHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriHub',
      theme: AppTheme.light(),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
