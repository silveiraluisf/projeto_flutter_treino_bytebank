import 'package:flutter/material.dart';
import 'package:bytebank/screens/dashboard.dart';

void main() {
  runApp(const ByteBankApp());
  }

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.blueAccent[700]),
          appBarTheme: AppBarTheme(color: Colors.green[900])),
      home: const Dashboard(),
    );
  }
}
