import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<T?> pushNamed<T, S>(
    String routeName, {
    S? arguments,
  }) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<T?> pushNamedAndRemoveUntil<T, S>(
    String routeName, {
    S? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void pop<T>({
    T? arguments,
  }) {
    return navigatorKey.currentState!.pop(arguments);
  }

  void popUntil(String routeName, {arguments, navigationFlow}) {
    navigatorKey.currentState!.popUntil((r) => r.isFirst);
  }
}
