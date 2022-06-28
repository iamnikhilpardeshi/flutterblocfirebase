import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocfirebaseauth/Models/user_model.dart';
import 'package:blocfirebaseauth/Repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;

  StreamSubscription<User>? _userSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isEmpty
              ? AppState.authenticated(authRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    _userSubscription =
        _authRepository.user.listen((user) => add(AppUserChanged(user)));
  }

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    unawaited(_authRepository.logout());
  }

  @override
  Future<void> close() async {
    _userSubscription?.cancel();
    return super.close();
  }
}
