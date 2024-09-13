import 'package:equatable/equatable.dart';

abstract class FireStoreState extends Equatable {
  const FireStoreState();
}

class FireStoreInitial extends FireStoreState {
  @override
  List<Object?> get props => [];
}

class StudentsLoaded extends FireStoreState {
  final List<Map<String, dynamic>> students;

  const StudentsLoaded(this.students);

  @override
  List<Object?> get props => [students];
}
class FireStoreLoading extends FireStoreState {
  @override
  List<Object?> get props => [];
}
class FireStoreSuccess extends FireStoreState {
  @override
  List<Object?> get props => [];
}
class FireStoreError extends FireStoreState {
  final String message;

  const FireStoreError(this.message);

  @override
  List<Object?> get props => [message];
}