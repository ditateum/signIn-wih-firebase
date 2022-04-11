import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_firebase/bloc/auth_bloc.dart';
import 'package:sign_in_firebase/model/user_model.dart';
import 'package:sign_in_firebase/view/form/sign_in_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.userModel,
  }) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
              (route) => false,
            );
          } else if (authState is AuthFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(authState.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome ${userModel.name}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthSignOut());
                    },
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
