import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mvvm_bloc/models/password.dart';
import 'package:mvvm_bloc/models/username.dart';
import 'package:mvvm_bloc/router/route_path.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/services/navigation_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  LoginViewModel(
      {required AuthenticationService authenticationService,
      required NavigationService navigationService})
      : _authenticationService = authenticationService,
        _navigationService = navigationService,
        super(const LoginState()) {
    _authenticationStatusSubscription =
        _authenticationService.status.listen((status) async {
      add(LoginStatusChanged(status));
      switch (status) {
        case AuthenticationStatus.authenticated:
          await showHome();
          break;
        default:
          return;
      }
    });
  }

  final AuthenticationService _authenticationService;
  final NavigationService _navigationService;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is LoginStatusChanged) {
      yield* _mapAuthenticationStatusChangedToState(event);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationService.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
        );
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Stream<LoginState> _mapAuthenticationStatusChangedToState(
    LoginStatusChanged event,
  ) async* {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        yield const LoginState(
            authenticationStatus: AuthenticationStatus.unauthenticated);
        break;
      case AuthenticationStatus.authenticated:
        yield const LoginState(
            authenticationStatus: AuthenticationStatus.authenticated);
        break;
      default:
        yield const LoginState(
            authenticationStatus: AuthenticationStatus.unauthenticated);
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    // _authenticationService.dispose();
    return super.close();
  }

  Future<void> showHome() async {
    await _navigationService.pushNamedAndRemoveUntil(RoutePath.home);
  }
}
