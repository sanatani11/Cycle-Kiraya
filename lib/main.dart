import 'package:cycle_kiraya/choose.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var kDarkScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  // ],).then((fn){
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: kDarkScheme.primaryContainer,
        )),
      ),
      theme: ThemeData().copyWith(
          //useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: const Color.fromARGB(255, 170, 177, 232),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          )),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 18))),
      home: const Choose(),
    ),
  );
  // });//
}
