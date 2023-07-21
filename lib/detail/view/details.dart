
import 'package:flutter/material.dart';
import 'package:peachpicks/models/movies.dart';

import 'details_content_view.dart';
import 'poster_view.dart';

/// Bottomsheet modal content displaying detail view for a movie 
class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { },
      child: DraggableScrollableSheet(
        initialChildSize: 0.72,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 17, 17, 17),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)
              )
            ),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PosterView(movie: movie),
                  DetailsContentView(movie: movie),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



