import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_kiraya/users/dashboard.dart';
import 'package:cycle_kiraya/widgets/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _key = GlobalKey<FormState>();
  bool _isLogin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredMobile = '';
  bool _isAuthenticating = false;
  File? _selectedImage;

  void submitInfo() async {
    final isValid = _key.currentState!.validate();
    if (!isValid) {
      return;
    }

    _key.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        final storage = await FirebaseStorage.instance
            .ref()
            .child('user-image')
            .child('${userCredentials.user!.uid}.jpg');
        await storage.putFile(_selectedImage!);
        final imageUrl = await storage.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${userCredentials.user!.uid}')
            .set({
          'mobile': _enteredMobile,
          'email': _enteredEmail,
          'image-url': imageUrl,
          'user-id': userCredentials.user!.uid,
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication failed!'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLogin ? const Text('Login') : const Text('Signing Up'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 120, 150, 202),
            Color.fromARGB(255, 80, 100, 149),
            Color.fromARGB(255, 97, 109, 166),
          ], begin: Alignment.topRight, end: Alignment.bottomRight),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(right: 20, left: 20, top: 40),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white10),
              width: double.infinity,
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!_isLogin)
                        UserImagePicker(
                          onPickedImage: (image) {
                            _selectedImage = image;
                          },
                        ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter Your Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Enter a valid email-id';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (!_isLogin)
                        TextFormField(
                          scrollPadding: const EdgeInsets.only(bottom: 10),
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                          ),
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          initialValue: null,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length != 10) {
                              return 'Enter a valid mobile number.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredMobile = newValue!;
                          },
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        scrollPadding: const EdgeInsets.only(bottom: 10),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        autocorrect: false,
                        initialValue: null,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length < 6) {
                            return 'Password must be of at least 8 characters.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (_isAuthenticating) const CircularProgressIndicator(),
                      if (!_isAuthenticating)
                        ElevatedButton.icon(
                          onPressed: submitInfo,
                          icon: _isLogin
                              ? const Icon(Icons.login)
                              : const Icon(Icons.person_add),
                          label: _isLogin
                              ? const Text('Login')
                              : const Text('SignUp'),
                        ),
                      if (!_isAuthenticating)
                        TextButton(
                          child: !_isLogin
                              ? const Text('Already an user?')
                              : const Text('New User? Register.'),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
