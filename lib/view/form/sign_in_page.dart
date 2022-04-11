import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_firebase/bloc/auth_bloc.dart';
import 'package:sign_in_firebase/view/form/sign_up_page.dart';
import 'package:sign_in_firebase/view/home_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _emailC = TextEditingController();
    final _passwordC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthLoaded) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  userModel: authState.userModel,
                ),
              ),
              (route) => false,
            );
          } else if (authState is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(authState.error)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextField(
                  controller: _emailC,
                  decoration: const InputDecoration(labelText: 'Your Email'),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextField(
                  obscureText: true,
                  controller: _passwordC,
                  decoration: const InputDecoration(labelText: 'Your Password'),
                ),
                const SizedBox(
                  height: 26,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState is AuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      width: double.infinity,
                      height: 45,
                      margin: const EdgeInsets.symmetric(
                        vertical: 26,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthLoginEvent(
                                  email: _emailC.text,
                                  password: _passwordC.text,
                                ),
                              );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.amber,
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Sign In'),
                      ),
                    );
                  },
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Don\'t Have account? sign up',
                      style: TextStyle(
                          color: Colors.black45,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
