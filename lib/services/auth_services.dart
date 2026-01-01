import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;


  Future<AuthResponse> signUp(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }


  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }


  Session? get currentSession => _supabase.auth.currentSession;


  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}