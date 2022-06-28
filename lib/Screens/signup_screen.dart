import 'package:blocfirebaseauth/Cubit/signup/cubit/signup_cubit.dart';
import 'package:blocfirebaseauth/Repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider<SignupCubit>(
          create: (_) => SignupCubit(
            context.read<AuthRepository>(),
          ),
          child: const SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.error) {}
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return state.status == SignupStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: () {
                  context.read<SignupCubit>().signupFormSubmitted();
                },
                child: const Text('Sign Up'),
              );
      },
    );
  }
}
