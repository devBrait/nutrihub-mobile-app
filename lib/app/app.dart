import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import '../features/auth/presentation/login/login_screen.dart';

class NutriHubApp extends StatelessWidget {
  const NutriHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriHub',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.login,
      routes: {AppRoutes.login: (_) => const LoginScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}
