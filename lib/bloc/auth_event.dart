part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthRegisterdEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthRegisterdEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});
}

class AuthSignOut extends AuthEvent {}
