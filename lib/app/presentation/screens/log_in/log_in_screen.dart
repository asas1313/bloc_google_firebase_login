import 'package:bloc_google_firebase_login/app/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../dashboard/dashboard.dart';
import 'bloc/log_in_form_bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LogInFormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log In"),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            }
            if (state is AuthError) {
              // Showing the error message if the user has entered invalid credentials
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final emailController = TextEditingController(text: "");
              final passwordController = TextEditingController(text: "");
              if (state is Loading) {
                // Showing the loading indicator while the user is LogIng in
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UnAuthenticated) {
                // Showing the sign in form if the user is not authenticated
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/sign_in.png",
                            height: 100,
                          ),
                          const Text("Log In",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(bottom: size.height * 0.02)),
                          _EmailField(
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          SizedBox(height: size.height * 0.01),
                          _PasswordField(
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          SizedBox(height: size.height * 0.01),
                          _SubmitButton(
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          SizedBox(height: size.height * 0.01),
                          const _SignUpLinkButton(),
                        ]),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const _EmailField(
      {required this.emailController,
      required this.passwordController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<LogInFormBloc, LogInFormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            onChanged: (value) {
              context.read<LogInFormBloc>().add(EmailEdited(value));
            },
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              helperText: 'A complete, valid email e.g. joe@gmail.com',
              errorText: !state.isEmailValid
                  ? 'Please ensure the email entered is valid'
                  : null,
              hintText: 'Email',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            ),
            onFieldSubmitted: (value) => _submit(
              context: context,
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const _PasswordField({
    required this.emailController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<LogInFormBloc, LogInFormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<LogInFormBloc>().add(PasswordEdited(value));
            },
            onFieldSubmitted: (value) => _submit(
              context: context,
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const _SubmitButton(
      {required this.emailController,
      required this.passwordController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInFormBloc, LogInFormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: state.isEmailValid && state.isPasswordValid
                    ? () => _submit(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                        )
                    : null,
                child: const Text("Log In"),
              );
      },
    );
  }
}

class _SignUpLinkButton extends StatelessWidget {
  const _SignUpLinkButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        // Navigating to the SignUp screen
        onPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen())),
        child: const Text("Sign Up"));
  }
}

_submit({
  required BuildContext context,
  required String email,
  required String password,
}) {
  context.read<AuthBloc>().add(LogInRequested(email, password));
}
