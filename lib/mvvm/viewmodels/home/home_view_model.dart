import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_bloc/mvvm/models/models.dart';
import 'package:mvvm_bloc/router/route_path.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/services/navigation_service.dart';
import 'package:mvvm_bloc/services/user_service.dart';

part 'home_view_event.dart';
part 'home_view__state.dart';

class HomeViewModel extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewModel({
    required NavigationService navigationService,
    required AuthenticationService authenticationService,
    required UserService userService,
  })   : _authenticationService = authenticationService,
        _userRepository = userService,
        _navigationService = navigationService,
        super(const HomeViewState.unknown()) {
    _authenticationStatusSubscription = _authenticationService.status.listen(
      authenticationStatusChangedHandler,
    );
  }

  void authenticationStatusChangedHandler(status) async {
    add(AuthenticationStatusChanged(status));
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        await showLogin();
        break;
      default:
        return;
    }
  }

  final AuthenticationService _authenticationService;
  final UserService _userRepository;
  final NavigationService _navigationService;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<HomeViewState> mapEventToState(
    HomeViewEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationService.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    //_authenticationService.dispose();
    return super.close();
  }

  Future<HomeViewState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const HomeViewState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return user != null
            ? HomeViewState.authenticated(user)
            : const HomeViewState.unauthenticated();
      default:
        return const HomeViewState.unknown();
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }

  Future<void> showLogin() async {
    await _navigationService.pushNamedAndRemoveUntil(RoutePath.login);
  }
}
