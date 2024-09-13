import 'package:equatable/equatable.dart';

abstract class CheckAuthEvent extends Equatable{
  const CheckAuthEvent();

}
class SignOutEvent extends CheckAuthEvent {
  @override
  List<Object?> get props => [];
}

class CheckUserEvent extends CheckAuthEvent {
  @override
  List<Object?> get props => [];
}
