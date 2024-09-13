import 'package:equatable/equatable.dart';

abstract class FireStoreEvent extends Equatable {
  const FireStoreEvent();
}

class AddStudentEvent extends FireStoreEvent {
  final String name;
  final String dob;
  final String gender;

  const AddStudentEvent(this.name, this.dob, this.gender);

  @override
  List<Object?> get props => [name, dob, gender];
}

class FetchStudentsEvent extends FireStoreEvent {
  @override
  List<Object?> get props => [];
}
