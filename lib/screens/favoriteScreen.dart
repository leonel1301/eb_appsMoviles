import 'package:eb_appsmoviles/models/comicsModel.dart';
import 'package:eb_appsmoviles/persistence/repository/comic_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  ComicRepository comicRepository = ComicRepository();
  List<SuperHero> superheroes = [];

  @override
  initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    final favoriteAnimes = await comicRepository.getAll();
    if (mounted) {
      setState(() {
        superheroes = favoriteAnimes;
      });
    }
  }

  void delete(SuperHero superHero) {
    setState(() {
      superheroes.remove(superHero);
      comicRepository.delete(superHero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your favorites'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: superheroes.isEmpty
            ? noFavorites()
            : ComicList(
                superHeroes: superheroes,
                onDelete: delete,
              ),
      ),
    );
  }
}

Widget noFavorites() {
  return const Center(
    child: Text('You have no favorites yet'),
  );
}

class ComicList extends StatelessWidget {
  const ComicList({super.key, required this.superHeroes, required this.onDelete});
  final List<SuperHero> superHeroes;
  final Function(SuperHero) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: superHeroes.length,
      itemBuilder: (context, index) {
        final anime = superHeroes[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(anime.imageUrl),
            title: Text(anime.name),
            trailing: IconButton(
              onPressed: () => onDelete(anime),
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }
}
