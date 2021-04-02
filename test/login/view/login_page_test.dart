import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm_bloc/services/authentication_service.dart';
import 'package:mvvm_bloc/views/login_view.dart';
import 'package:mvvm_bloc/views/widgets/login_form.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationService {}

void main() {
  group('LoginPage', () {
    late AuthenticationService authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('is routable', () {
      expect(LoginView.route(), isA<MaterialPageRoute>());
    });

    testWidgets('renders a LoginForm', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            home: Scaffold(body: LoginView()),
          ),
        ),
      );
      expect(find.byType(LoginForm), findsOneWidget);
    });
  });
}
