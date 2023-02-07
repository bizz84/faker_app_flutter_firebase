import 'package:faker_app_flutter_firebase/src/routing/app_router.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomSignInScreen extends ConsumerWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = [EmailAuthProvider()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SignInScreen(
        providers: authProviders,
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            context.goNamed(AppRoute.profile.name);
          }),
          AuthStateChangeAction<UserCreated>((context, state) {
            context.goNamed(AppRoute.profile.name);
          }),
        ],
      ),
    );
  }
}
