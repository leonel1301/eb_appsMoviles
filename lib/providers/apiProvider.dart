import 'package:dio/dio.dart';
import 'package:eb_appsmoviles/models/comicsModel.dart';
import 'package:flutter/material.dart';

class HeroProvider with ChangeNotifier {
  Dio dio = Dio();
  List<SuperHero> heroes = [];
  int get searchCount   => heroes.length;
  bool noResultsFound = false;

  Future<void> searchHero(String heroName) async {
    final response = await dio
        .get('https://superheroapi.com/api/10157703717092094/search/$heroName');
    if (response.statusCode == 200 && response.data['results'] != null) {
      List<dynamic> heroesJson = response.data['results'];
      heroes = heroesJson.map((json) => SuperHero.fromJson(json)).toList();
      noResultsFound = false;
    } else {
      noResultsFound = true;
      heroes.clear();
    }
    notifyListeners();
  }
}
