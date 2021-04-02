import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_bloc/models/user.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/services/user_service.dart';

part 'home_view_event.dart';
part 'home_view__state.dart';

class HomeViewModel extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewModel({
    required AuthenticationService authenticationService,
    required UserService userService,
  })   : _authenticationService = authenticationService,
        _userRepository = userService,
        super(const HomeViewState.unknown()) {
    _authenticationStatusSubscription = _authenticationService.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationService _authenticationService;
  final UserService _userRepository;
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
    _authenticationService.dispose();
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
}
