import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sign_in_firebase/model/user_model.dart';
import 'package:sign_in_firebase/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // NOTE: REGISTER
      if (event is AuthRegisterdEvent) {
        try {
          emit(AuthLoading());
          UserModel userModel = await _authService.signUp(
            name: event.name,
            email: event.email,
            password: event.password,
          );
          emit(AuthLoaded(userModel));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
        // NOTE: LOGIN
      } else if (event is AuthLoginEvent) {
        try {
          emit(AuthLoading());
          UserModel userModel = await _authService.signIn(
            email: event.email,
            password: event.password,
          );
          emit(AuthLoaded(userModel));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
        // NOTE: SIGN OUT
      } else if (event is AuthSignOut) {
        try {
          emit(AuthLoading());
          await _authService.signOut();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
