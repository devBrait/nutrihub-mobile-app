import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../app/theme/app_colors.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.cream100.withValues(alpha: 0.65),
        );
    final link = base?.copyWith(
      color: AppColors.cream100,
      fontWeight: FontWeight.w600,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: base,
        children: [
          const TextSpan(text: 'By continuing you agree to our '),
          TextSpan(
            text: 'Terms',
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: open Terms of Use
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: open Privacy Policy
              },
          ),
        ],
      ),
    );
  }
}
