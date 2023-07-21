part of './home_bloc.dart';

abstract class HomeEvent {}

class FetchMovies extends HomeEvent {}
class FetchLatestMovies extends HomeEvent {}
class FetchPopularMovies extends HomeEvent {}
class FetchTopMovies extends HomeEvent {}
class FetchUpcomingMovies extends HomeEvent {}


class ToggleMovieSection extends HomeEvent {
  ToggleMovieSection({ required this.section });

  final MovieSection section;
}


/// Depicts with section is being acted upon
enum MovieSection { latest, popular, top, upcoming }

extension MovieSectionString on MovieSection {
  String getName() {
    switch (this) {
      case MovieSection.latest: return "Latest movies";
      case MovieSection.popular: return "Popular movies";
      case MovieSection.top: return "Top movies";
      case MovieSection.upcoming: return "Upcoming movies";
    }
  }
}