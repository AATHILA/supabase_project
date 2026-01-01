import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/services/auth_services.dart';
import 'controllers/auth/auth_bloc/auth_bloc.dart';
import 'views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://croouujblppmqqerjcaj.supabase.co',
    anonKey: 'sb_publishable_23eqX9YOBlZM9W3oPLUciQ_uL6HGvKv',
  );

  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthService>(
      create: (_) => AuthService(),
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          context.read<AuthService>(),
        ),
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
    );
  }
}
