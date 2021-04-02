import 'package:flutter/material.dart';
import 'package:mvvm_bloc/router/route_path.dart';
import 'package:mvvm_bloc/views/home_view.dart';
import 'package:mvvm_bloc/views/login_view.dart';
import 'package:mvvm_bloc/views/splash_view.dart';

class Routes {
  static Route<T> generateRoute<T>(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.login:
        return MaterialPageRoute<T>(builder: (_) => LoginView());
      case RoutePath.home:
        return MaterialPageRoute<T>(builder: (_) => HomeView());
      case RoutePath.splash:
        return MaterialPageRoute<T>(builder: (_) => SplashView());
      default:
        return MaterialPageRoute<T>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
