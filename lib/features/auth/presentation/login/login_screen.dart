import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/app_logo.dart';
import '../providers/auth_providers.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_social_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signInWithGoogleProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Não foi possível entrar: ${next.error}'),
          ),
        );
      }
    });

    final isSigningIn = ref.watch(signInWithGoogleProvider).isLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? const [
            AppColors.neutral950,
            AppColors.authGradientDarkMid,
            AppColors.jungle700,
          ]
        : const [AppColors.jungle700, AppColors.jungle500, AppColors.jungle400];
    final gradientStops = isDark
        ? const [0.0, 0.6, 1.0]
        : const [0.0, 0.55, 1.0];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: gradientColors.last,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
              stops: gradientStops,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isTablet =
                    constraints.maxWidth >= AppDimensions.tabletBreakpoint;
                final gutter = isTablet
                    ? AppDimensions.gutterTablet
                    : AppDimensions.gutterPhone;
                final logoWidth = (constraints.maxWidth * 0.55).clamp(
                  160.0,
                  240.0,
                );

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: gutter),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      AppLogo(width: logoWidth),
                      const SizedBox(height: AppDimensions.s6),
                      Text(
                        'Eat well, effortlessly',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
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
                        onPressed: isSigningIn
                            ? null
                            : () => ref
                                  .read(signInWithGoogleProvider.notifier)
                                  .signIn(),
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
        ),
      ),
    );
  }
}
