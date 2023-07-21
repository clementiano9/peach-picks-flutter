import 'package:flutter/material.dart';
import 'package:peachpicks/detail/view/details.dart';

import '../../models/movies.dart';
import '../bloc/home_bloc.dart';

/// Horizontal scrolling list view of movies in a section
class MoviesCarousel extends StatelessWidget {
  const MoviesCarousel({super.key, required this.movieState });
  final MovieSectionState movieState;
  
  @override
  Widget build(BuildContext context) {
    List<Movie> movies = movieState.movies;

    if (movieState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCarouselItem(movie: movie);
        },
      );
    }
  }
}

// Opens a detailed view of the [movie] in a bottomsheet modal
void _showMovieDetails(BuildContext context, Movie movie) {
    Scaffold.of(context).showBottomSheet((context) {
        return Details(movie: movie);
      },
      backgroundColor: Colors.black54,
      clipBehavior: Clip.antiAliasWithSaveLayer
    );
  }

class MovieCarouselItem extends StatelessWidget {
  final Movie movie;
  const MovieCarouselItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => _showMovieDetails(context, movie),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
