import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});
  Stream<String> getLoadingMessages() {
    final message = [
      'Cargando pelicuas',
      'Comprando palomitas de maiz',
      'Cargando populares',
      'Llamando al director',
      'Ya casi.....',
      'Esto esta tardando mas   de lo esperado'
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return message[step];
    }).take(message.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Por favor espere'),
        const SizedBox(height: 20),
        const CircularProgressIndicator(
          strokeWidth: 3,
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Cargando');
            return Text(snapshot.data!);
          },
        )
      ]),
    );
  }
}
