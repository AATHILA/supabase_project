import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/auth/auth_bloc/auth_bloc.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Welcome back!")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
          } else if (state is AuthError) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                  obscureText: true,
                ),
                const SizedBox(height: 30),

                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        SignInRequested(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ),
                      );
                    },
                    child: const Text("LOGIN"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}