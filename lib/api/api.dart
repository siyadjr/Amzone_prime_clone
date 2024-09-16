import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/constant.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _trendingMoviesurl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constant.apikey}';
  static const _popularMovies =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constant.apikey}';

  Future<List<Movie>> getPopularMovie() async {
    final response = await http.get(Uri.parse(_trendingMoviesurl));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('somthing happend');
    }
  }

  Future<List<Movie>> getAllMovies() async {
    final responce = await http.get(Uri.parse(_popularMovies));
    if (responce.statusCode == 200) {
      final decodeData = json.decode(responce.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Wrong issue detected');
    }
  }

  Future<List<Movie>> getTrendingMovie() async {
    final response = await http.get(Uri.parse(_trendingMoviesurl));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;

      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('somthing happend');
    }
  }
}
