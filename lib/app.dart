import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/container.dart';
import 'package:mvvm_bloc/router/route_path.dart';
import 'package:mvvm_bloc/router/routes.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/services/navigation_service.dart';
import 'package:mvvm_bloc/services/user_service.dart';
import 'package:mvvm_bloc/viewmodels/home/home_view_model.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationService,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationService authenticationService;
  final UserService userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationService,
      child: BlocProvider(
        create: (_) => HomeViewModel(
          authenticationService: authenticationService,
          userService: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    final navigationService = container<NavigationService>();
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      builder: (context, child) {
        // return BlocListener<HomeViewModel, HomeViewState>(
        //   listener: (context, state) {
        //     switch (state.status) {
        //       case AuthenticationStatus.authenticated:
        //         navigationService.pushNamedAndRemoveUntil(RoutePath.home);
        //         break;
        //       case AuthenticationStatus.unauthenticated:
        //         navigationService.pushNamedAndRemoveUntil(RoutePath.login);
        //         break;
        //       default:
        //         break;
        //     }
        //   },
        //   child: child,
        // );
        return child!;
      },
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutePath.login,
    );
  }
}
