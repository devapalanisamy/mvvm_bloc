part of 'home_view_model.dart';

class HomeViewState extends Equatable {
  const HomeViewState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const HomeViewState.unknown() : this._();

  const HomeViewState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const HomeViewState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
