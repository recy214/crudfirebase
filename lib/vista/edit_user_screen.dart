import 'package:flutter/material.dart';
import '../firestore_service.dart';
import '../modelo/user.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  EditUserScreen({required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _phoneNumber = widget.user.phoneNumber;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        widget.user.name = _name;
        widget.user.phoneNumber = _phoneNumber;
      });
      FirestoreService().updateUser(widget.user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su nombre, por favor';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: InputDecoration(labelText: 'Numero de celular'),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phoneNumber = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su numero de celular, por favor';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Favor de ingresar un numero de celular valido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
