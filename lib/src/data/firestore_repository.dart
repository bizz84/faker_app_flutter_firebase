import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker_app_flutter_firebase/src/data/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> addJob(String uid, String title, String company) =>
      _firestore.collection('jobs').add({
        'uid': uid,
        'title': title,
        'company': company,
      });

  Future<void> updateJob(
          String uid, String jobId, String title, String company) =>
      _firestore.doc('jobs/$jobId').update({
        'uid': uid,
        'title': title,
        'company': company,
      });

  Future<void> deleteJob(String uid, String jobId) =>
      _firestore.doc('jobs/$jobId').delete();

  Query<Job> jobsQuery(String uid) {
    return _firestore
        .collection('jobs')
        .withConverter(
          fromFirestore: (snapshot, _) => Job.fromMap(snapshot.data()!),
          toFirestore: (job, _) => job.toMap(),
        )
        .where('uid', isEqualTo: uid);
  }
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
