part of 'sign_up_form_bloc.dart';

abstract class SignUpFormState extends Equatable {
  const SignUpFormState();

  @override
  List<Object> get props => [];
}

class SignUpFormInitial extends SignUpFormState {}

// When the user edits Email field the state is changed to Email if field contents fulfils email requirements.
class DisplayName extends SignUpFormState {
  @override
  List<Object> get props => [];
}

// When the user edits Email field the state is changed to Email if field contents fulfils email requirements.
class Email extends SignUpFormState {
  @override
  List<Object> get props => [];
}

// When the user edits Password field the state is changed to Pasword if field contents fulfils requirements.
class Password extends SignUpFormState {
  @override
  List<Object> get props => [];
}

// When the user edits ConfirmPassword field the state is changed to ConfirmPasword if field's value is equal Password field.
class ConfirmPassword extends SignUpFormState {
  @override
  List<Object> get props => [];
}

class SignUpFormsValidate extends SignUpFormState {
  const SignUpFormsValidate({
    this.displayName = "",
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isConfirmPasswordValid,
    this.formErrorMessage = "",
    this.emailErrorMessage = "",
    this.passwordErrorMessage = "",
    this.confirmPasswordErrorMessage = "",
    required this.isLoading,
  });

  final String displayName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final String formErrorMessage;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String confirmPasswordErrorMessage;
  final bool isLoading;

  SignUpFormsValidate copyWith({
    String? displayName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    String? formErrorMessage,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? confirmPasswordErrorMessage,
    bool? isLoading,
  }) {
    return SignUpFormsValidate(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        displayName,
        email,
        password,
        confirmPassword,
        isEmailValid,
        isPasswordValid,
        isConfirmPasswordValid,
        formErrorMessage,
        emailErrorMessage,
        passwordErrorMessage,
        confirmPasswordErrorMessage,
        isLoading,
      ];
}
