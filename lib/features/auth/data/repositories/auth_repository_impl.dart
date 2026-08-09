import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Stream<AppUser?> get authStateChanges {
    return _remoteDataSource.onAuthStateChange.map(
      (state) => _mapUser(state.session?.user),
    );
  }

  @override
  Future<void> signInWithGoogle() => _remoteDataSource.signInWithGoogle();

  @override
  Future<void> signOut() => _remoteDataSource.signOut();

  AppUser? _mapUser(supabase.User? user) {
    if (user == null) return null;
    final metadata = user.userMetadata ?? const {};
    return AppUser(
      id: user.id,
      email: user.email,
      displayName: metadata['full_name'] as String? ?? metadata['name'] as String?,
      avatarUrl: metadata['avatar_url'] as String?,
    );
  }
}
