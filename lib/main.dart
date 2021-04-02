import 'package:flutter/widgets.dart';
import 'package:mvvm_bloc/app.dart';
import 'package:mvvm_bloc/container.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/services/user_service.dart';

void main() {
  registerDependencies();
  runApp(App(
    authenticationService: container<AuthenticationService>(),
    userRepository: container<UserService>(),
  ));
}
