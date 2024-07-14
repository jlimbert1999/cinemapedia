import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/respositories/local_storage_respository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
