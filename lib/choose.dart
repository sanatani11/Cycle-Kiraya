import 'package:cycle_kiraya/users/auth.dart';
import 'package:flutter/material.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Who are you?',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 157, 134, 193),
          Color.fromARGB(255, 106, 130, 178),
          Color.fromARGB(255, 123, 134, 233)
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const AuthScreen()));
                      },
                      child: Card(
                        elevation: 15,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(12),
                                bottomStart: Radius.circular(12),
                                topEnd: Radius.zero,
                                bottomEnd: Radius.zero),
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer
                                .withOpacity(0.3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'USER?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'I want to rent a bycle',
                                selectionColor:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 15,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadiusDirectional.only(
                                topEnd: Radius.circular(12),
                                bottomEnd: Radius.circular(12)),
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer
                                .withOpacity(0.3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ADMIN?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'I am manager..',
                                selectionColor:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
