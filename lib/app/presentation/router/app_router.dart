import 'package:flutter/material.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/log_in/log_in_screen.dart';

class AppRouter {
  static const String home = '/';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const LogInScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
