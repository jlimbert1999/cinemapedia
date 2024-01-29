import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final viewRouter = const <Widget>[HomeView(), SizedBox(), FavoriteView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRouter,
      ),
      bottomNavigationBar: CustonBottomNavigator(
        currentIndex: pageIndex,
      ),
    );
  }
}
