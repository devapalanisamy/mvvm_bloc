import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm_bloc/models/password.dart';
import 'package:mvvm_bloc/models/username.dart';
import 'package:mvvm_bloc/viewmodels/login/login_view_model.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late LoginViewModel loginBloc;
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    loginBloc =
        LoginViewModel(authenticationRepository: authenticationRepository);
  });

  group('LoginBloc', () {
    test('initial state is LoginState', () {
      expect(loginBloc.state, const LoginState());
    });

    group('LoginSubmitted', () {
      blocTest<LoginViewModel, LoginState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when login succeeds',
        build: () {
          when(
            () => authenticationRepository.logIn(
              username: 'username',
              password: 'password',
            ),
          ).thenAnswer((_) => Future.value('user'));
          return loginBloc;
        },
        act: (bloc) {
          bloc
            ..add(const LoginUsernameChanged('username'))
            ..add(const LoginPasswordChanged('password'))
            ..add(const LoginSubmitted());
        },
        expect: () => const <LoginState>[
          LoginState(
            username: Username.dirty('username'),
            status: FormzStatus.invalid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.valid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionInProgress,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<LoginViewModel, LoginState>(
        'emits [LoginInProgress, LoginFailure] when logIn fails',
        build: () {
          when(() => authenticationRepository.logIn(
                username: 'username',
                password: 'password',
              )).thenThrow(Exception('oops'));
          return loginBloc;
        },
        act: (bloc) {
          bloc
            ..add(const LoginUsernameChanged('username'))
            ..add(const LoginPasswordChanged('password'))
            ..add(const LoginSubmitted());
        },
        expect: () => const <LoginState>[
          LoginState(
            username: Username.dirty('username'),
            status: FormzStatus.invalid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.valid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionInProgress,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionFailure,
          ),
        ],
      );
    });
  });
}
