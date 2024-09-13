import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_signup_app/bloc/check_auth_bloc.dart';
import 'package:firebase_signup_app/bloc/check_auth_event.dart';
import 'package:firebase_signup_app/bloc/check_auth_state.dart';
import 'package:firebase_signup_app/bloc/firestore_bloc.dart';
import 'package:firebase_signup_app/features/app/splash_screen/splash_screen.dart';
import 'package:firebase_signup_app/features/user_auth/screen/pages/login_page.dart';
import 'package:firebase_signup_app/features/user_auth/screen/pages/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAO-2olAM69Q1xiMKi_GmACdyJlfJr_SUI',
    appId: '1:3415591825:android:c3f0735d56a5a4a6d76830',
    messagingSenderId: '3415591825',
    projectId: 'fir-signupapp-bb4ef',
    storageBucket: 'fir-signupapp-bb4ef.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<CheckAuthBloc>(
          create: (context) => CheckAuthBloc(),
        ),
        BlocProvider<FireStoreBloc>(create: (context) => FireStoreBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter firebase',
        home: SplashScreen(
          child: BlocBuilder<CheckAuthBloc, CheckAuthState>(
            builder: (BuildContext context, state) {
              context.read<CheckAuthBloc>().add(
                CheckUserEvent()
              );
              if (state is Authenticated) {
                return const NavigationMenu();
              } else {
                return const LoginPage();
              }
            },
          ),
        ),
      )
    );
  }
}
