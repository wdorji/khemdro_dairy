import 'package:flutter/material.dart';
import 'package:khemdro/backend/gsheets.dart';

import 'Alert.dart';

// An entry form widget that takes in SIN & amount of dairy collected
class EntryForm extends StatefulWidget {
  const EntryForm({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _SIN = "default";
    String _dairy_collected = "default";
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 200, 3),
            title: const Text("Welcome to Khemdro Dairy")),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("SIN"),
              TextFormField(
                onSaved: (newValue) {
                  _SIN = newValue!;
                },
              ),
              const Text("Dairy Collected"),
              TextFormField(
                onSaved: (newValue) {
                  _dairy_collected = newValue!;
                },
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("Pressed button!");
                    print("info collected from form:");
                    print(_SIN);
                    print(_dairy_collected);
                    try {
                      int.parse(_SIN);
                    } catch (e) {
                      showAlertDialog(context, "Please enter valid SIN");
                    }
                    try {
                      double.parse(_dairy_collected);
                    } catch (e) {
                      showAlertDialog(context, "Please enter valid dairy");
                    }
                    createNewRow(_SIN, _dairy_collected);
                  }

                  //
                },
                child: const Text('Submit entry'),
              )
            ],
          ),
        ));
  }
}
