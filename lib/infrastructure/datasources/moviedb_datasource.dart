import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';

import '../models/moviedb/moviedb_response.dart';

class MovieDbDataSource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with $id not found');
    final movieDetailsDB = MovieDetails.fromJson(response.data);
    return MovieMapper.movieDetailsToEntity(movieDetailsDB);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }
}
