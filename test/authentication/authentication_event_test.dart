// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_bloc/authentication/authentication.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';

void main() {
  group('AuthenticationEvent', () {
    group('LoggedOut', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationLogoutRequested(),
          AuthenticationLogoutRequested(),
        );
      });
    });

    group('AuthenticationStatusChanged', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationStatusChanged(AuthenticationStatus.unknown),
          AuthenticationStatusChanged(AuthenticationStatus.unknown),
        );
      });
    });
  });
}
