import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FunctionsRepository {
  FunctionsRepository(this._functions);
  final FirebaseFunctions _functions;

  Future<void> deleteAllUserJobs() async {
    // TODO: Implement
  }
}

final functionsRepositoryProvider = Provider<FunctionsRepository>((ref) {
  return FunctionsRepository(FirebaseFunctions.instance);
});
