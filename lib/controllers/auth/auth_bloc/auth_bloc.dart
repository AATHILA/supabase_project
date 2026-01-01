import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/services/auth_services.dart';
part 'auth_event.dart';
part 'auth_state.dart';




class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signIn(event.email, event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });


    on<SignOutRequested>((event, emit) async {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    });
  }
}
