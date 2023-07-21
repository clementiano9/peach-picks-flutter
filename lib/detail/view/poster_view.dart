import 'package:flutter/material.dart';
import 'package:peachpicks/models/movies.dart';

/// Display a large movie poster 
class PosterView extends StatelessWidget {
  const PosterView({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: NetworkImage(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
          height: 410,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 12,
          top: 12,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white54,
          ),
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              child: const Icon(Icons.close),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          )
        )
      ],
    );
  }
}