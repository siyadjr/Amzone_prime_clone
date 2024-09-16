import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/movie_details.dart';
import 'package:netflix_clone/widgets/watch.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovie(); // Fetching trending movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Movie>>(
        future: trendingMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while fetching data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (snapshot.hasData) {
            // If the API returns a list of movies, display them in a ListView
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                    width: 50,
                  ),
                  title: Text(
                    movie.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    movie.releaseDate,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    // Handle movie tap, possibly navigate to a detailed screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Watch(
                          movieName: movie.title,
                          posterPath:
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          description: movie.overView,
                          duration: '02:32',
                          genres: 'Comedy,Drama',
                          rating: 3.53,
                          releaseYear: movie.releaseDate,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            // If no data is returned
            return const Center(
              child: Text(
                'No movies available.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
