import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustonBottomNavigator extends StatelessWidget {
  final int currentIndex;
  const CustonBottomNavigator({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    context.go('/home/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Catergorias'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos')
      ],
    );
  }
}
