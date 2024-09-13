import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signup_app/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignUpEvent) {
      yield AuthLoading();
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await userCredential.user!.sendEmailVerification();
        yield AuthSuccess(userCredential.user!);
      } on FirebaseAuthException catch (e) {
        yield AuthError(e.toString());
      }
    } else if (event is SignInEvent) {
      yield AuthLoading();
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if(userCredential.user!.emailVerified) {
          yield AuthSuccess(userCredential.user!);
        } else {
          await userCredential.user!.sendEmailVerification();
          yield const AuthError("Email not verified, please check your email and verify.");
        }
      } on FirebaseAuthException catch (e) {
        yield AuthError(e.toString());
      }
    }
  }
}