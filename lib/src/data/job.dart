import 'package:equatable/equatable.dart';

/// Model class for documents in the jobs collection
class Job extends Equatable {
  const Job({required this.uid, required this.title, required this.company});
  final String uid;
  final String title;
  final String company;

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      uid: map['uid'] as String,
      title: map['title'] as String,
      company: map['company'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'title': title,
        'company': company,
      };

  @override
  List<Object?> get props => [uid, title, company];
}
