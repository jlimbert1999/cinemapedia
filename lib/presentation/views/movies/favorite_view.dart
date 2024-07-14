import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FavoriteMovieList();
  }
}

class _FavoriteMovieList extends ConsumerState {
  List movies = [];
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadMovies();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref.read(favoriteMoviesProvider.notifier).loadMovies();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriteMoviesProvider).values.toList();

    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_outline_sharp,
              size: 60,
            ),
            Text('Ohh no!!',
                style: TextStyle(
                  fontSize: 30,
                  color: colors.primary,
                )),
            const Text('Sin peliculas favoritas',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            FilledButton(
                onPressed: () {
                  context.go('/home/0');
                },
                child: const Text('Empesar a buscar'))
          ],
        ),
      );
    }
    return Scaffold(
      body: MovieMasonry(movies: movies, loadNextPage: loadNextPage),
    );
  }
}
