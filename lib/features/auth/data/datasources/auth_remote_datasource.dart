import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const String googleOAuthRedirectUrl =
      'io.supabase.nutrihub://login-callback/';

  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  User? get currentUser => _client.auth.currentUser;

  Future<void> signInWithGoogle() {
    return _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: googleOAuthRedirectUrl,
    );
  }

  Future<void> signOut() => _client.auth.signOut();
}
