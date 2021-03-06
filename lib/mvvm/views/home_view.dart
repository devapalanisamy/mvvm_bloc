import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/container.dart';
import 'package:mvvm_bloc/mvvm/viewmodels/home/home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return container<HomeViewModel>();
      },
      child: BlocBuilder<HomeViewModel, HomeViewState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    final userId = context.select(
                      (HomeViewModel bloc) => bloc.state.user.id,
                    );
                    return Text('UserID: $userId');
                  },
                ),
                ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () {
                    context
                        .read<HomeViewModel>()
                        .add(AuthenticationLogoutRequested());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
