import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_signup_app/bloc/firestore_event.dart';
import 'package:firebase_signup_app/bloc/firestore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FireStoreBloc extends Bloc<FireStoreEvent, FireStoreState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FireStoreBloc() : super(FireStoreInitial());

  @override
  Stream<FireStoreState> mapEventToState(FireStoreEvent event) async* {
    if (event is AddStudentEvent) {
      yield FireStoreLoading();
      try {
        await _firestore.collection('students').add({
          'name': event.name,
          'dob': event.dob,
          'gender': event.gender,
        });
        yield FireStoreSuccess();
      } catch (e) {
        yield FireStoreError(e.toString());
      }

    } else if (event is FetchStudentsEvent) {
      try {
        yield FireStoreLoading();
        QuerySnapshot snapshot = await _firestore.collection('students').get();
        List<Map<String, dynamic>> students = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'dob': doc['dob'],
            'gender': doc['gender'],
          };
        }).toList();
        yield StudentsLoaded(students);
      } catch (e) {
        yield FireStoreError(e.toString());
      }
    }
  }
}