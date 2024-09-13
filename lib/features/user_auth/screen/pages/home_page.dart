import 'package:firebase_signup_app/bloc/firestore_bloc.dart';
import 'package:firebase_signup_app/bloc/firestore_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/firestore_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final ValueNotifier<String?> _genderNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<FireStoreBloc, FireStoreState>(
      listener: (context, state) {
        if (state is FireStoreLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is FireStoreSuccess) {
          Navigator.of(context, rootNavigator: true)
              .pop(); // Close the loading dialog
          _nameController.clear();
          _dobController.clear();
          _genderNotifier.value = null;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student added successfully')),
          );
        } else if (state is FireStoreError) {
          Navigator.of(context, rootNavigator: true)
              .pop(); // Close the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(
                controller: _nameController,
                label: "Name",
                hintText: 'Enter student name',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _dobController,
                label: 'Date of Birth',
                hintText: 'Select date of birth',
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dobController.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              ValueListenableBuilder<String?>(
                valueListenable: _genderNotifier,
                builder: (context, value, child) {
                  return DropdownButton<String>(
                    hint: const Text('Select Gender'),
                    value: value,
                    onChanged: (newValue) {
                      _genderNotifier.value = newValue;
                    },
                    items: ['Male', 'Female', 'Other'].map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<FireStoreBloc>().add(AddStudentEvent(
                        _nameController.text,
                        _dobController.text,
                        _genderNotifier.value!,
                      ));
                },
                child: const Text('Add Student'),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      readOnly: onTap != null,
      onTap: onTap,
    );
  }
}
