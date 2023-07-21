part of './home_bloc.dart';

enum HomeStatus { initial, success, failure }

/// The state of each movie section
class MovieSectionState extends Equatable {
  final List<Movie> movies;
  final bool isExpanded;
  final bool isLoading;

  const MovieSectionState({
    this.movies = const [], 
    this.isExpanded = false, 
    this.isLoading = false,
  });

  /// Copy and update values
  MovieSectionState copyWith({
    List<Movie>? movies,
    bool? isExpanded,
    bool? isLoading,
  }) {
    return MovieSectionState(
      movies: movies ?? this.movies,
      isExpanded: isExpanded ?? this.isExpanded,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  MovieSectionState toggleSection() {
    return MovieSectionState(
      movies: movies,
      isExpanded: !isExpanded,
      isLoading: isLoading,
    );
  }

  @override
  List<Object?> get props => [movies, isExpanded, isLoading];
}

class HomeState extends Equatable {
  final HomeStatus status;
  final MovieSectionState latestMovies;
  final MovieSectionState popularMovies;
  final MovieSectionState topMovies;
  final MovieSectionState upcomingMovies;

  const HomeState({
    this.status = HomeStatus.initial,
    this.latestMovies = const MovieSectionState(isExpanded: true),
    this.popularMovies = const MovieSectionState(isExpanded: true),
    this.topMovies = const MovieSectionState(isExpanded: false),
    this.upcomingMovies = const MovieSectionState(isExpanded: false),
  });

  /// Copy and update values
  HomeState copyWith({
    HomeStatus? status,
    MovieSectionState? latestMovies,
    MovieSectionState? popularMovies,
    MovieSectionState? topMovies,
    MovieSectionState? upcomingMovies,
  }) {
    return HomeState(
      status: status ?? this.status,
      latestMovies: latestMovies ?? this.latestMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topMovies: topMovies ?? this.topMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
    );
  }
  
  @override
  List<Object?> get props => [status, latestMovies, popularMovies, topMovies, upcomingMovies];

}