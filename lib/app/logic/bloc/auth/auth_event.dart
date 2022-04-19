part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// When the user LogIng in with email and password this event is called and the [AuthRepository] is called to sign in the user
class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  LogInRequested(this.email, this.password);
}

// When the user LogIng up with email and password this event is called and the [AuthRepository] is called to sign up the user
class SignUpRequested extends AuthEvent {
  final String? displayName;
  final String email;
  final String password;

  SignUpRequested(this.displayName, this.email, this.password);
}

// When the user LogIng in with google this event is called and the [AuthRepository] is called to sign in the user
class GoogleSignInRequested extends AuthEvent {}

// When the user LogIng out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends AuthEvent {}
