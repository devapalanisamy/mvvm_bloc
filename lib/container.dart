import 'package:get_it/get_it.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/services/navigation_service.dart';
import 'package:mvvm_bloc/services/user_service.dart';
import 'package:mvvm_bloc/viewmodels/home/home_view_model.dart';
import 'package:mvvm_bloc/viewmodels/login/login_view_model.dart';

final container = GetIt.instance;

registerDependencies() {
  registerViewModels();
  registerServices();
}

registerViewModels() {
  container.registerFactory(() => HomeViewModel(
        authenticationService: container<AuthenticationService>(),
        userService: container<UserService>(),
      ));
  container.registerFactory(() => LoginViewModel(
        authenticationService: container<AuthenticationService>(),
      ));
}

registerServices() {
  container.registerLazySingleton(() => AuthenticationService());
  container.registerLazySingleton(() => UserService());
  container.registerLazySingleton(() => NavigationService());
}
