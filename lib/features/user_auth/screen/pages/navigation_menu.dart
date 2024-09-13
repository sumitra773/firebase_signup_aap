import 'package:firebase_signup_app/bloc/check_auth_event.dart';
import 'package:firebase_signup_app/bloc/check_auth_state.dart';
import 'package:firebase_signup_app/features/user_auth/screen/pages/home_page.dart';
import 'package:firebase_signup_app/features/user_auth/screen/pages/view_students_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/check_auth_bloc.dart';
import '../globle/toast.dart';
import 'login_page.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    ViewStudentsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Student'),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<CheckAuthBloc>().add(SignOutEvent());
              }),
        ],
      ),
      body: BlocListener<CheckAuthBloc, CheckAuthState>(
          listener: (context, state) {
            if (state is CheckAuthInitial) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
              );
              showToast(message: "Sign out successfully");
            }
          },
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'View Student',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
