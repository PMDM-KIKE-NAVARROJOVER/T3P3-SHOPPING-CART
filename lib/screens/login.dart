import 'package:flutter/material.dart';
import 'package:t3_shopping_list/screens/products.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // global key to uniquely identify the Form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _eMailInput(),
              _passwordInput(),
              _loginButton(),
            ], // <Widget>[]
          ), // Column
        ) // Padding
    ); // Form
  }

  Widget _eMailInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'User',
          hintText: 'Write your email address',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ), // InputDecoration

        // validator: value contains the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sorry, user can\'t be empty.';
          }
          return null; // field is valid
        },
      ), // TextFormField
    ); // Container
  }

  Widget _passwordInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: true,
        obscuringCharacter: '*', // password is not shown
        decoration: InputDecoration(
          hintText: 'Write your password',
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ), // InputDecoration

        // validator: value contains the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sorry, password can not be empty';
          }
          if (value.length < 5) {
            return 'Sorry, password length must be 5 characters or greater';
          }

          return null; // field is valid
        },
      ), // TextFormField
    ); // Container
  }

  Widget _loginButton() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server, save the information in a database,...
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(' Trying to login ...')),
            );

            // navigate to list products screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
          }
        },
      ), // ElevatedButton
    ); // Container
  }
}