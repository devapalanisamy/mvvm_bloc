import 'package:get_it/get_it.dart';
import 'package:mvvm_bloc/mvvm/viewmodels/home/home_view_model.dart';
import 'package:mvvm_bloc/mvvm/viewmodels/login/login_view_model.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/services/navigation_service.dart';
import 'package:mvvm_bloc/services/user_service.dart';

final container = GetIt.instance;

registerDependencies() {
  registerViewModels();
  registerServices();
}

registerViewModels() {
  container.registerFactory(() => HomeViewModel(
        authenticationService: container<AuthenticationService>(),
        userService: container<UserService>(),
        navigationService: container<NavigationService>(),
      ));
  container.registerFactory(() => LoginViewModel(
        authenticationService: container<AuthenticationService>(),
        navigationService: container<NavigationService>(),
      ));
}

registerServices() {
  container.registerLazySingleton(() => AuthenticationService());
  container.registerLazySingleton(() => UserService());
  container.registerLazySingleton(() => NavigationService());
}
