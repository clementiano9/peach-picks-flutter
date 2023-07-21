import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:peachpicks/models/movies.dart';
import 'package:peachpicks/repository/movies_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiRepository repository;
  Timer? _timer;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<FetchMovies>(_onFetchInitialMovies);
    on<FetchLatestMovies>(_onFetchLatestMovies);
    on<FetchPopularMovies>(_onFetchPopularMovies);
    on<FetchTopMovies>(_onTopMovies);
    on<FetchUpcomingMovies>(_onUpcomingMovies);
    
    on<ToggleMovieSection>(_onToggleMovieSection);
    startFetchingData();
  }

  /// Periodically update latest movies
  void startFetchingData() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (state.latestMovies.isExpanded) {
        add(FetchLatestMovies());
      } else {
        stopFetchingData();
      }
    });
  }

  /// Event to start 
  Future<void> _onFetchInitialMovies(
      FetchMovies event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.initial));
    add(FetchLatestMovies());
    add(FetchPopularMovies());
  }
  
  
  Future<void> _onFetchLatestMovies(FetchLatestMovies event, Emitter<HomeState> emit) async {

    try {
      final latestMoviesResponse = await repository.loadLatestMovies();
      final latestMovies = latestMoviesResponse.results;

      emit(state.copyWith(
          status: HomeStatus.success,
          latestMovies: state.latestMovies
              .copyWith(movies: latestMovies, isLoading: false)));
    } catch (e) {
      print("Fetched movies error: ${e.toString()}");
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _onFetchPopularMovies(FetchPopularMovies event, Emitter<HomeState> emit) async {
    emit(state.copyWith(popularMovies: state.popularMovies.copyWith(isLoading: true)));
    try {
      final popularMoviesResponse = await repository.loadPopularMovies();
      final popularMovies = popularMoviesResponse.results;

      emit(state.copyWith(
          status: HomeStatus.success,
          popularMovies: state.popularMovies
              .copyWith(movies: popularMovies, isLoading: false)));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _onTopMovies(FetchTopMovies event, Emitter<HomeState> emit) async {
    emit(state.copyWith(topMovies: state.topMovies.copyWith(isLoading: true)));
    try {
      final moviesResponse = await repository.loadTopMovies();
      final movies = moviesResponse.results;
      emit(state.copyWith(
          topMovies:
              state.topMovies.copyWith(movies: movies, isLoading: false)));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _onUpcomingMovies(FetchUpcomingMovies event, Emitter<HomeState> emit) async {
    emit(state.copyWith(upcomingMovies: state.upcomingMovies.copyWith(isLoading: true)));
    print("Fetching upcoming... ");
    try {
      final moviesResponse = await repository.loadUpcomingMovies();
      final movies = moviesResponse.results;
      emit(state.copyWith(
          upcomingMovies:
              state.upcomingMovies.copyWith(movies: movies, isLoading: false)));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
  
  void _onToggleMovieSection(ToggleMovieSection event, Emitter<HomeState> emit) {
    switch (event.section) {
      case MovieSection.latest:
        emit(state.copyWith(latestMovies: state.latestMovies.toggleSection()));
        if (state.latestMovies.isExpanded) {  // Start refreshing
          startFetchingData();
        } else {
          stopFetchingData();
        }
        break;
      case MovieSection.popular:
        emit(state.copyWith(popularMovies: state.popularMovies.toggleSection()));
        break;
      case MovieSection.top:
        emit(state.copyWith(topMovies: state.topMovies.toggleSection()));
        if (state.topMovies.isExpanded && 
            state.topMovies.movies.isEmpty) {
          add(FetchTopMovies());
        }
        break;
      case MovieSection.upcoming:
        emit(state.copyWith(
            upcomingMovies: state.upcomingMovies.toggleSection()));
        if (state.upcomingMovies.isExpanded &&
            state.upcomingMovies.movies.isEmpty) {
          add(FetchUpcomingMovies());
        }
        break;
    }
  }

  /// Stop periodical updates
  void stopFetchingData() {
    _timer?.cancel();
  }

}
