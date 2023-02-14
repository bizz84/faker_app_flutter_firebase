import 'package:equatable/equatable.dart';

/// Model class for documents in the jobs collection
class Job extends Equatable {
  const Job({required this.title, required this.company});
  final String title;
  final String company;

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      title: map['title'] as String,
      company: map['company'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'company': company,
      };

  @override
  List<Object?> get props => [title, company];
}
