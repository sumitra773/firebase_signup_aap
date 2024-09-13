import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signup_app/bloc/auth_state.dart';
import 'package:firebase_signup_app/bloc/check_auth_event.dart';
import 'package:firebase_signup_app/bloc/check_auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckAuthBloc extends Bloc<CheckAuthEvent, CheckAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CheckAuthBloc() : super(CheckAuthInitial());

  @override
  Stream<CheckAuthState> mapEventToState(CheckAuthEvent event) async* {
    if(event is CheckUserEvent) {
      try {
        User user = _auth.currentUser!;
        if(user.emailVerified) {
          yield Authenticated(user);
        } else {
          yield Unauthenticated();
        }
      } catch (e) {
        yield Unauthenticated();
      }
    } else if(event is SignOutEvent) {
      try {
        await _auth.signOut();
        yield CheckAuthInitial();
      } catch (e) {
        yield Unauthenticated();
      }
    }
  }
}