import 'package:flutter/material.dart';
import 'package:sign_in_firebase/view/form/sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            const SizedBox(
              height: 26,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Your Email'),
            ),
            const SizedBox(
              height: 26,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Your Password'),
            ),
            Container(
              width: double.infinity,
              height: 45,
              margin: const EdgeInsets.symmetric(
                vertical: 26,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Sign Up'),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
                child: const Text(
                  'Have account? sign in',
                  style: TextStyle(
                      color: Colors.black45,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
