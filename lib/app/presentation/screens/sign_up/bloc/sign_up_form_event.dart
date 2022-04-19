part of 'sign_up_form_bloc.dart';

abstract class SignUpFormEvent extends Equatable {
  const SignUpFormEvent();

  @override
  List<Object> get props => [];
}

class FormInitial extends SignUpFormEvent {
  const FormInitial();

  @override
  List<Object> get props => [];
}

// When the user edits displayName field this event is called
class DisplayNameEdited extends SignUpFormEvent {
  final String displayName;
  const DisplayNameEdited(this.displayName);

  @override
  List<Object> get props => [displayName];
}

// When the user edits email field this event is called and vlidity is checked
class EmailEdited extends SignUpFormEvent {
  final String email;
  const EmailEdited(this.email);

  @override
  List<Object> get props => [email];
}

// When the user edits password field this event is called and vlidity is checked
class PasswordEdited extends SignUpFormEvent {
  final String password;
  const PasswordEdited(this.password);

  @override
  List<Object> get props => [password];
}

// When the user edits password field this event is called and vlidity is checked
class ConfirmPasswordEdited extends SignUpFormEvent {
  final String confirmPassword;
  const ConfirmPasswordEdited(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

// When the user clics connect button this event is called connection proceeds
class FormSubmitted extends SignUpFormEvent {
  const FormSubmitted();

  @override
  List<Object> get props => [];
}
