import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comic App', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Image.network(
                "https://assetsio.reedpopcdn.com/ASM2022001_Variant1(Eminem)-header.jpg?width=1200&height=1200&fit=bounds&quality=70&format=jpg&auto=webp"),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.go('/search');
                },
                child: const Text('Search superheroes')),
                  ],
                ),
          )),
    );
  }
}
