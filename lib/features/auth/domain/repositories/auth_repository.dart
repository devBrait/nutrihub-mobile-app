import '../entities/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> get authStateChanges;

  Future<void> signInWithGoogle();

  Future<void> signOut();
}
