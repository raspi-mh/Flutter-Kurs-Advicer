//import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/presentation/advicer/advicer_page.dart';
import 'package:advicer/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/bloc/advicer_bloc.dart';


// di depensdency injection
void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //di.init;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advicer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: BlocProvider(
          create: (BuildContext context) => AdvicerBloc(),
          child: const AdvicerPage()),
    );
  }
}