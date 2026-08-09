import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = AuthRemoteDataSource(Supabase.instance.client);
  return AuthRepositoryImpl(dataSource);
});

final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final signInWithGoogleProvider =
    AsyncNotifierProvider<SignInWithGoogleNotifier, void>(
      SignInWithGoogleNotifier.new,
    );

class SignInWithGoogleNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signIn() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signInWithGoogle(),
    );
  }
}
