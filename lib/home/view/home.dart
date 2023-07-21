import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import 'movies_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error loading data'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
          return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  const SliverAppBar(
                    expandedHeight: 420,
                    // floating: true,
                    pinned: true,
                    backgroundColor: Colors.black87,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text("Peach Picks",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        background: Image(
                          image: AssetImage('assets/images/johnwickbanner.jpg'),
                          fit: BoxFit.cover,
                        )),
                    surfaceTintColor: Colors.black87,
                    stretch: true,
                  ),
                ];
              },
              body: Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 17, 17, 17)),
                child: const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        MoviesList()
                      ],
                    ),
                  ),
                ),
              )
            );
        },
        ),
      ));
  }
}

