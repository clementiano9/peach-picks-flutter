
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peachpicks/home/view/movies_carousel.dart';

import '../bloc/home_bloc.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    void _onToggle(MovieSection section) {
      context.read<HomeBloc>().add(ToggleMovieSection(section: section));
    }

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.status == HomeStatus.initial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Column(
          children: [
            _buildMovieSection(
              MovieSection.latest,
              state.latestMovies,
              () => _onToggle(MovieSection.latest)
            ),
            _buildMovieSection(
              MovieSection.popular,
              state.popularMovies,
              () => _onToggle(MovieSection.popular)
            ),
             _buildMovieSection(
              MovieSection.top, 
              state.topMovies,
              () => _onToggle(MovieSection.top)
            ),
            _buildMovieSection(
              MovieSection.upcoming,
              state.upcomingMovies,
              () => _onToggle(MovieSection.upcoming)
            ),
          ],
        );
      }
    });
  }

  Widget _buildMovieSection(
      MovieSection section, final MovieSectionState sectionState, Function onToggleSection) {
    bool isExpanded = sectionState.isExpanded;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
        child: ListTile(
          title: Text(
            section.getName(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            size: 30,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          onTap: () => onToggleSection(),
        ),
      ),
      if (isExpanded)
        SizedBox(
          height: 200,
          child: MoviesCarousel(movieState: sectionState),
        ),
    ]);
  }
}

