import 'package:flutter/material.dart';
import 'package:netflix_clone/model/movies.dart';

class SuggestedMoviesCard extends StatelessWidget {
  final int index;
  final Movie movie;

  SuggestedMoviesCard({super.key, required this.index, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}', // Fetching image from network
          ),
          fit: BoxFit.contain, // Cover the entire container
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.black54, // Semi-transparent background for text
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          child: Text(
            movie.title, // Use movie title
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
