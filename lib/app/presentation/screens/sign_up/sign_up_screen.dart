import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../dashboard/dashboard.dart';
import '../log_in/log_in_screen.dart';
import 'bloc/sign_up_form_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignUpFormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
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
              final displayNameController = TextEditingController(text: "");
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
                            "assets/images/sign_up.png",
                            height: 100,
                          ),
                          const Text("Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(bottom: size.height * 0.02)),
                          _DisplayNameField(controller: displayNameController),
                          SizedBox(height: size.height * 0.01),
                          _EmailField(controller: emailController),
                          SizedBox(height: size.height * 0.01),
                          _PasswordField(controller: passwordController),
                          SizedBox(height: size.height * 0.01),
                          const _ConfirmPasswordField(),
                          SizedBox(height: size.height * 0.01),
                          _SubmitButton(
                            displayName: displayNameController,
                            email: emailController,
                            password: passwordController,
                          ),
                          SizedBox(height: size.height * 0.01),
                          const _LogInLinkButton(),
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

class _DisplayNameField extends StatelessWidget {
  final TextEditingController controller;
  const _DisplayNameField({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SignUpFormBloc, SignUpFormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<SignUpFormBloc>().add(DisplayNameEdited(value));
              },
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Display name',
                helperText: 'A name You want to see on display',
                hintText: 'Display Name',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              )),
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  const _EmailField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SignUpFormBloc, SignUpFormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<SignUpFormBloc>().add(EmailEdited(value));
              },
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'A complete, valid email e.g. joe@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Please ensure the email entered is valid'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              )),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SignUpFormBloc, SignUpFormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            controller: controller,
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
              context.read<SignUpFormBloc>().add(PasswordEdited(value));
            },
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SignUpFormBloc, SignUpFormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              helperText: '''Passwords should match''',
              helperMaxLines: 2,
              labelText: 'Confirm password',
              errorMaxLines: 2,
              errorText: !state.isConfirmPasswordValid
                  ? '''Passwords must match'''
                  : null,
            ),
            onChanged: (value) {
              context.read<SignUpFormBloc>().add(ConfirmPasswordEdited(value));
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final TextEditingController displayName;
  final TextEditingController email;
  final TextEditingController password;
  const _SubmitButton(
      {required this.displayName,
      required this.email,
      required this.password,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignUpFormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: state.isEmailValid && state.isPasswordValid
                    ? () => context.read<AuthBloc>().add(SignUpRequested(
                        displayName.text, email.text, password.text))
                    : null,
                child: const Text("Sign Up"),
              );
      },
    );
  }
}

class _LogInLinkButton extends StatelessWidget {
  const _LogInLinkButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        // Navigating to the SignUp screen
        onPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LogInScreen())),
        child: const Text("Log In"));
  }
}
