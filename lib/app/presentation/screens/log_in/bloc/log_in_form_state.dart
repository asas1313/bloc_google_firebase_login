part of 'log_in_form_bloc.dart';

abstract class LogInFormState extends Equatable {
  const LogInFormState();

  @override
  List<Object> get props => [];
}

class LogInFormInitial extends LogInFormState {}

// When the user edits Email field the state is changed to Email if field contents fulfils email requirements.
class Email extends LogInFormState {
  @override
  List<Object> get props => [];
}

// When the user edits Password field the state is changed to Pasword if field contents fulfils requirements.
class Password extends LogInFormState {
  @override
  List<Object> get props => [];
}

class LogInFormsValidate extends LogInFormState {
  const LogInFormsValidate({
    required this.email,
    required this.password,
    required this.isEmailValid,
    required this.isPasswordValid,
    this.formErrorMessage = "",
    this.emailErrorMessage = "",
    this.passwordErrorMessage = "",
    required this.isLoading,
  });

  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final String formErrorMessage;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final bool isLoading;

  LogInFormsValidate copyWith(
      {String? email,
      String? password,
      bool? isEmailValid,
      bool? isPasswordValid,
      String? formErrorMessage,
      String? emailErrorMessage,
      String? passwordErrorMessage,
      bool? isLoading}) {
    return LogInFormsValidate(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        formErrorMessage,
        emailErrorMessage,
        passwordErrorMessage,
        isLoading,
      ];
}
