import 'package:faker_app_flutter_firebase/src/routing/app_router.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomProfileScreen extends ConsumerWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = [EmailAuthProvider()];
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      providers: authProviders,
      actions: [
        SignedOutAction((context) {
          context.goNamed(AppRoute.signIn.name);
        }),
      ],
    );
  }
}
