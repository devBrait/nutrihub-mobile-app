import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.appBar,
    this.statusBarStyle,
  });

  final Widget child;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;

  /// Overrides the automatic light/dark status bar icon style. Leave null to
  /// have it follow the current theme brightness.
  final SystemUiOverlayStyle? statusBarStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedBackground = backgroundColor ?? theme.colorScheme.surface;
    final isDark = theme.brightness == Brightness.dark;
    final overlayStyle =
        statusBarStyle ??
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: resolvedBackground,
          systemNavigationBarIconBrightness: isDark
              ? Brightness.light
              : Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
        );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: resolvedBackground,
        appBar: appBar,
        body: SafeArea(child: child),
      ),
    );
  }
}
