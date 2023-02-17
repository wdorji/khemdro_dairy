import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 200, 3),
            title: const Text("Welcome to Khemdro Dairy")),
        body: Form(
          key: _formKey,
          child: Column(
            children: const [
              Text("SIN"),
              TextField(),
              Text("Dairy Collected"),
              TextField()
            ],
          ),
        ));
  }
}
