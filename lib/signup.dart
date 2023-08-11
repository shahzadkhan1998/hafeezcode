import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userscreen/provider/allprovider.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  final signState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration and Sign-In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 20),
                 ElevatedButton(
                onPressed: () async {
                if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                {
                    ref.read(authProvider.notifier).registerWithEmailAndPassword(_emailController.text.trim(), _passwordController.text.trim(),context);

                }

                 
                },
                child: const Text('Sign Up'),
              ),
                 const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                 ref.read(authProvider.notifier).signInWithGoogle(context);
                },
                child: const Text('Sign in with Google'),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}