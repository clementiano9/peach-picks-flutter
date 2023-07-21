import 'dart:convert';
import 'dart:io';

import 'package:peachpicks/models/movies.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiRepository {
  Future<MoviesResponse> loadLatestMovies();
  Future<MoviesResponse> loadPopularMovies();
  Future<MoviesResponse> loadTopMovies();
  Future<MoviesResponse> loadUpcomingMovies();        
} 
/// Handles asynchronous requests to the Movies API endpoints
class MoviesRepository extends ApiRepository {
  final apiKey = env['API_KEY'];

  @override
  Future<MoviesResponse> loadLatestMovies() async {
    return _loadMovies('https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey');
  }
  
  @override
  Future<MoviesResponse> loadPopularMovies() {
    return _loadMovies('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey');
  }
  
  @override
  Future<MoviesResponse> loadTopMovies() {
    return _loadMovies('https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey');
  }
  
  @override
  Future<MoviesResponse> loadUpcomingMovies() {
    return _loadMovies('https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey');
  }

  /// Fetches and parses a list of movies from the [url] endpoint
  Future<MoviesResponse> _loadMovies(String url) async {
    final response = await http.get(Uri.parse(url));
    final latestMovies = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return MoviesResponse.fromJson(latestMovies as Map<String, dynamic>);
    } else {
      throw Exception('Unable to fetch latest movies: ${response.statusCode}');
    }
  }
}