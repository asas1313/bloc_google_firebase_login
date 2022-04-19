import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/regexp_constants.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormsValidate> {
  SignUpFormBloc()
      : super(const SignUpFormsValidate(
          displayName: "",
          email: "example@gmail.com",
          password: "",
          confirmPassword: "",
          isEmailValid: false,
          isPasswordValid: false,
          isConfirmPasswordValid: false,
          isLoading: false,
        )) {
    on<FormInitial>(_onFormInitial);
    on<DisplayNameEdited>(_onDisplayNameEdited);
    on<EmailEdited>(_onEmailEdited);
    on<PasswordEdited>(_onPasswordEdited);
    on<ConfirmPasswordEdited>(_onConfirmPasswordEdited);
    on<FormSubmitted>(_onFormSubmitted);
  }

  bool _isEmailValid(String email) {
    return kEmailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return kPasswordRegExp.hasMatch(password);
  }

  bool _isConfirmPasswordValid(String confirmPassword, String password) {
    return confirmPassword == password;
  }

  _onFormInitial(FormInitial event, Emitter<SignUpFormsValidate> emit) {
    // When form is loaded or reseted we will send the FormInitial Event to the
    // SignUpFormBloc to handle it and emit the SignUpFormInitial state
    emit(const SignUpFormsValidate(
      displayName: "",
      email: "",
      password: "",
      confirmPassword: "",
      isEmailValid: false,
      isPasswordValid: false,
      isConfirmPasswordValid: false,
      emailErrorMessage: "",
      passwordErrorMessage: "",
      confirmPasswordErrorMessage: "",
      formErrorMessage: "",
      isLoading: false,
    ));
  }

  _onDisplayNameEdited(
      DisplayNameEdited event, Emitter<SignUpFormsValidate> emit) {
    // When User edits Email field we will send the EmailEdited Event to the
    // SignUpFormBloc to handle it and emit the EmailCorrect state if so
    emit(state.copyWith(
      email: event.displayName,
      isEmailValid: _isEmailValid(event.displayName),
    ));
  }

  _onEmailEdited(EmailEdited event, Emitter<SignUpFormsValidate> emit) {
    // When User edits Email field we will send the EmailEdited Event to the
    // SignUpFormBloc to handle it and emit the EmailCorrect state if so
    emit(state.copyWith(
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  _onPasswordEdited(PasswordEdited event, Emitter<SignUpFormsValidate> emit) {
    // When User edits Password field we will send the PasswordEdited Event to the
    // LogInFormBloc to handle it and emit the PasswordCorrect state if so
    emit(state.copyWith(
      password: event.password,
      isPasswordValid: _isPasswordValid(event.password),
    ));
  }

  _onConfirmPasswordEdited(
      ConfirmPasswordEdited event, Emitter<SignUpFormsValidate> emit) {
    // When User edits ConfirmPassword field we will send the
    // ConfirmPasswordEdited Event to the LogInFormBloc to handle it and
    // emit the PasswordCorrect state if so
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      isConfirmPasswordValid:
          _isConfirmPasswordValid(event.confirmPassword, state.password),
    ));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<SignUpFormsValidate> emit) {
    // When User presses Connect button we will send the FormSubmitted Event to the
    // SignUpFormBloc to handle it and emit the Loading state
    emit(state.copyWith(
      isLoading: true,
    ));
  }
}
