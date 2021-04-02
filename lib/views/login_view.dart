import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/viewmodels/login/login_view_model.dart';
import 'package:mvvm_bloc/views/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginViewModel(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationService>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
