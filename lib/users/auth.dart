import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _key = GlobalKey<FormState>();

  void submitInfo() {
    _key.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('karte ahi kuchh'),
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
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white10),
              width: double.infinity,
              padding: const EdgeInsets.only(right: 20, left: 20),
              margin: const EdgeInsets.only(right: 20, left: 20, top: 40),
              child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      ),
                      const SizedBox(
                        height: 12,
                      ),
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
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton.icon(
                        onPressed: submitInfo,
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Already an user?'))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
