import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/respositories/movie_repository_impl.dart';

final movieRespositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDataSource());
});
