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
            backgroundColor: Color.fromRGBO(45, 92, 126, 1),
            title: const Text("Welcome to Khemdro Dairy")),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset('images/khemdro_logo.jpg'),
              const SizedBox(height: 20),
              const Text("SIN", style: TextStyle(fontSize: 20)),
              TextFormField(
                onSaved: (newValue) {
                  _SIN = newValue!;
                },
              ),
              const SizedBox(height: 20),
              const Text("Dairy Collected", style: TextStyle(fontSize: 20)),
              TextFormField(
                onSaved: (newValue) {
                  _dairy_collected = newValue!;
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("Pressed button!");
                    print("info collected from form:");
                    print(_SIN);
                    print(_dairy_collected);
                    try {
                      int.parse(_SIN);
                    } catch (e) {
                      showAlertDialog(context, "Invalid Credentials",
                          "Please enter valid SIN");
                    }
                    try {
                      double _dairy_collected_dbl =
                          double.parse(_dairy_collected);
                      if (_dairy_collected_dbl < 0) {
                        throw Exception();
                      } else {
                        try {
                          await createNewRow(_SIN, _dairy_collected);
                          showAlertDialog(context, "Success",
                              "Entry for $_SIN has been submitted!");
                        } on ArgumentError catch (e) {
                          showAlertDialog(
                              context, "Invalid Credentials", e.message);
                        }
                      }
                    } catch (e) {
                      showAlertDialog(context, "Invalid Credentials",
                          "Please enter valid dairy");
                    }
                  }

                  //
                },
                child:
                    const Text('Submit entry', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ));
  }
}
