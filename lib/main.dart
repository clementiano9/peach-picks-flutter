import 'package:flutter/material.dart';
import 'package:peachpicks/home/view/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peachpicks/repository/movies_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotEnv;

import 'home/bloc/home_bloc.dart';

Future<void> main() async {
  await dotEnv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peach Picks',
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider(
        create: (context) => HomeBloc(MoviesRepository())..add(FetchMovies()),
        child: const MyHomePage(),
      ),
    );
  }
}



