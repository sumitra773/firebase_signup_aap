import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CheckAuthState extends Equatable {
  const CheckAuthState();
}

class CheckAuthInitial extends CheckAuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends CheckAuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends CheckAuthState {
  @override
  List<Object?> get props => [];
}
