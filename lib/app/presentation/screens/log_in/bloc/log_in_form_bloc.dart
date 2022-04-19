import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/regexp_constants.dart';

part 'log_in_form_event.dart';
part 'log_in_form_state.dart';

class LogInFormBloc extends Bloc<LogInFormEvent, LogInFormsValidate> {
  LogInFormBloc()
      : super(const LogInFormsValidate(
          email: "example@gmail.com",
          password: "",
          isEmailValid: false,
          isPasswordValid: false,
          isLoading: false,
        )) {
    on<FormInitial>(_onFormInitial);
    on<EmailEdited>(_onEmailEdited);
    on<PasswordEdited>(_onPasswordEdited);
    on<FormSubmitted>(_onFormSubmitted);
  }

  bool _isEmailValid(String email) {
    return kEmailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _onFormInitial(FormInitial event, Emitter<LogInFormsValidate> emit) {
    // When form is loaded or reseted we will send the FormInitial Event to the
    // LogInFormBloc to handle it and emit the LogInFormInitial state
    emit(const LogInFormsValidate(
      email: "",
      password: "",
      isEmailValid: false,
      isPasswordValid: false,
      emailErrorMessage: "",
      passwordErrorMessage: "",
      formErrorMessage: "",
      isLoading: false,
    ));
  }

  _onEmailEdited(EmailEdited event, Emitter<LogInFormsValidate> emit) {
    // When User edits Email field we will send the EmailEdited Event to the
    // LogInFormBloc to handle it and emit the EmailCorrect state if so
    emit(state.copyWith(
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  _onPasswordEdited(PasswordEdited event, Emitter<LogInFormsValidate> emit) {
    // When User edits Password field we will send the PasswordEdited Event to the
    // LogInFormBloc to handle it and emit the PasswordCorrect state if so
    emit(state.copyWith(
      password: event.password,
      isPasswordValid: _isPasswordValid(event.password),
    ));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<LogInFormsValidate> emit) {
    // When User presses Connect button we will send the FormSubmitted Event to the
    // LogInFormBloc to handle it and emit the Loading state
    emit(state.copyWith(
      isLoading: true,
    ));
  }
}
