import 'package:blocfirebaseauth/Bloc/app/app_bloc.dart';
import 'package:blocfirebaseauth/Config/routes.dart';
import 'package:blocfirebaseauth/Repositories/auth_repository.dart';
import 'package:blocfirebaseauth/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_builder/flow_builder.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authRepository = AuthRepository();
      runApp(App(authRepository: authRepository));
    },
    blocObserver: AppBlocObserver(),
  );
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  const App({
    Key? key,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FlowBuilder(
      state: context.select((AppBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateAppViewPages,
    ));
  }
}
