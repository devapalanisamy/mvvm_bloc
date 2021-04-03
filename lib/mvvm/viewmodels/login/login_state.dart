part of 'login_view_model.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.authenticationStatus = AuthenticationStatus.unauthenticated,
  });

  final FormzStatus status;
  final Username username;
  final Password password;

  final AuthenticationStatus authenticationStatus;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    AuthenticationStatus? authenticationStatus,
  }) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        authenticationStatus:
            authenticationStatus ?? this.authenticationStatus);
  }

  @override
  List<Object> get props => [status, username, password, authenticationStatus];
}
