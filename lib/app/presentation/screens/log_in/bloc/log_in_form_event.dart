part of 'log_in_form_bloc.dart';

abstract class LogInFormEvent extends Equatable {
  const LogInFormEvent();

  @override
  List<Object> get props => [];
}

class FormInitial extends LogInFormEvent {
  const FormInitial();

  @override
  List<Object> get props => [];
}

// When the user edits email field this event is called and vlidity is checked
class EmailEdited extends LogInFormEvent {
  final String email;
  const EmailEdited(this.email);

  @override
  List<Object> get props => [email];
}

// When the user edits password field this event is called and vlidity is checked
class PasswordEdited extends LogInFormEvent {
  final String password;
  const PasswordEdited(this.password);

  @override
  List<Object> get props => [password];
}

// When the user clics connect button this event is called connection proceeds
class FormSubmitted extends LogInFormEvent {
  const FormSubmitted();

  @override
  List<Object> get props => [];
}
