import 'package:flutter/material.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/watch.dart';

class SearchedMovies extends StatelessWidget {
  const SearchedMovies({
    super.key,
    required List<Movie> filteredMovies,
  }) : _filteredMovies = filteredMovies;

  final List<Movie> _filteredMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _filteredMovies.map((movie) {
        return ListTile(
            title:
                Text(movie.title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(movie.releaseDate,
                style: const TextStyle(color: Colors.white70)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => Watch(
                    movieName: movie.title,
                    description: movie.overView,
                    posterPath:
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    genres: 'Comedy . Romance',
                    rating: movie.voteAvarage,
                    releaseYear: movie.releaseDate.split('-')[0],
                    duration: '139',
                  ),
                ),
              );
            });
      }).toList(),
    );
  }
}
