import 'package:flutter/material.dart';
import 'package:peachpicks/models/movies.dart';

class DetailsContentView extends StatelessWidget {
  const DetailsContentView({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star,
                  size: 16, color: Colors.amber[600]),
              const SizedBox(width: 4),
              Text(
                movie.voteAverage.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${movie.voteCount} reviews',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (movie.video == true) 
          ElevatedButton(
            onPressed: () => _showSnackbar(context, movie),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow),
                SizedBox(width: 8),
                Text('Play'),
              ],
            )
          ),
          const SizedBox(height: 16),
          Text(
            movie.overview,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Release Date: ${movie.releaseDate}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}

_showSnackbar(BuildContext context, Movie movie) {
  var snackBar = SnackBar(
    content: Text(movie.title),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}