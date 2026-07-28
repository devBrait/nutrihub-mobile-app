import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/app_logo.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.jungle700,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet =
                constraints.maxWidth >= AppDimensions.tabletBreakpoint;
            final gutter = isTablet
                ? AppDimensions.gutterTablet
                : AppDimensions.gutterPhone;
            final logoWidth =
                (constraints.maxWidth * 0.55).clamp(160.0, 240.0);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  AppLogo(width: logoWidth),
                  const SizedBox(height: AppDimensions.s10),
                  Text(
                    'Eat well, effortlessly',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.s3),
                  Text(
                    'Your AI nutritionist plans meals,\nadapts your day and does the\ntracking for you.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.cream100.withValues(alpha: 0.75),
                          height: 1.6,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 3),
                  LoginSocialButton(
                    onPressed: () {
                      // TODO: implement Google Sign-In
                      debugPrint('Google sign-in tapped');
                    },
                  ),
                  const SizedBox(height: AppDimensions.s4),
                  const LoginFooter(),
                  const SizedBox(height: AppDimensions.s8),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
