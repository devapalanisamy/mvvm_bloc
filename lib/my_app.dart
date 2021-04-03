import 'package:flutter/material.dart';
import 'package:mvvm_bloc/container.dart';
import 'package:mvvm_bloc/router/route_path.dart';
import 'package:mvvm_bloc/router/routes.dart';
import 'package:mvvm_bloc/services/navigation_service.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final navigationService = container<NavigationService>();
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      builder: (context, child) {
        return child!;
      },
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutePath.login,
    );
  }
}
