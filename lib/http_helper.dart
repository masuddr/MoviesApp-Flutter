import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=be3842901d918b1ac508feff96a5d145';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlTopRated = '/top_rated?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase = 'https://api.themoviedb.org/3/search/movie?api_key=be3842901d918b1ac508feff96a5d145&query=';


  Future<List> findMovies(String title) async {
    final String query = urlSearchBase + title ;
    http.Response result = await http.get(query);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) =>
          Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return null;
    }  }


  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlTopRated + urlKey
        + urlLanguage;
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) =>
          Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return null;
    }
  }

}
