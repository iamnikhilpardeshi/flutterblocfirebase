import 'package:blocfirebaseauth/Cubit/login/cubit/login_cubit.dart';
import 'package:blocfirebaseauth/Repositories/auth_repository.dart';
import 'package:blocfirebaseauth/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => LoginCubit(
              context.read<AuthRepository>(),
            ),
            child: const LoginForm(),
          ),
        ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {}
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EmailInput(),
          const SizedBox(
            height: 8,
          ),
          _PasswordInput(),
          const SizedBox(
            height: 8,
          ),
          _LoginButton(),
          const SizedBox(
            height: 8,
          ),
          _SignupButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: () {
                  context.read<LoginCubit>().logInWithCredentials();
                },
                child: const Text('Login'),
              );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).push<void>(SignupScreen.route());
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
