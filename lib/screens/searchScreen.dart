import 'package:eb_appsmoviles/models/comicsModel.dart';
import 'package:eb_appsmoviles/persistence/repository/comic_repository.dart';
import 'package:eb_appsmoviles/providers/apiProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroSearchScreen extends StatefulWidget {
  const HeroSearchScreen({super.key});
  

  @override
  _HeroSearchScreenState createState() => _HeroSearchScreenState();
}

class _HeroSearchScreenState extends State<HeroSearchScreen> {
  ComicRepository comicRepository = ComicRepository();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Superhero'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Name of superhero',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Provider.of<HeroProvider>(context, listen: false)
                .searchHero(_controller.text),
            child: const Text('Search'),
          ),
          Consumer<HeroProvider>(builder: (context, heroProvider, child) {
            if (heroProvider.noResultsFound) {
              return const Text('No results found');
            }
            if (heroProvider.searchCount == 0) {
              return const SizedBox.shrink();
            }
            return Expanded(
              child: ListView.builder(
                itemCount: heroProvider.searchCount,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading:
                          Image.network(heroProvider.heroes[index].imageUrl),
                      title: Text(heroProvider.heroes[index].name),
                      subtitle: Text(
                          '${heroProvider.heroes[index].gender} - ${heroProvider.heroes[index].intelligence}'),
                      trailing: IconButton(
                        icon: Icon(Icons.favorite, color: heroProvider.heroes[index].isFavorite ? Colors.red : Colors.grey,),
                        onPressed: () async{
                          SuperHero hero = heroProvider.heroes[index];
                          await comicRepository.insert(hero);
                          setState(() {
                            hero.isFavorite = !hero.isFavorite;
                          });
                        },
                      ));
                },
              ),
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
