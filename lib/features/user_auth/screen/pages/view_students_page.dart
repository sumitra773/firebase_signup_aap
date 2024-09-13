import 'package:firebase_signup_app/bloc/firestore_event.dart';
import 'package:firebase_signup_app/bloc/firestore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/firestore_bloc.dart';

class ViewStudentsPage extends StatefulWidget {
  const ViewStudentsPage({super.key});

  @override
  State<ViewStudentsPage> createState() => _ViewStudentsPage();
}

class _ViewStudentsPage extends State<ViewStudentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<FireStoreBloc>().add(FetchStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FireStoreBloc, FireStoreState>(
        builder: (BuildContext context, state) {
          if (state is FireStoreLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FireStoreError) {
            return Center(child: Text(state.message));
          } else if (state is StudentsLoaded) {
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = state.students[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      data['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'DOB: ${data['dob']}',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey[700]),
                        ),
                        Text(
                          'Gender: ${data['gender']}',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
