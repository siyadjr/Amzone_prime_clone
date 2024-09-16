import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart';

class TvshowScreen extends StatefulWidget {
  const TvshowScreen({super.key});

  @override
  State<TvshowScreen> createState() => _TvshowScreenState();
}

class _TvshowScreenState extends State<TvshowScreen> {
  late Future<List<Movie>> popularMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = Api().getPopularMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Popular Shows'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: popularMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        popularMovies = Api().getAllMovies();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found.'));
          } else {
            final movies = snapshot.data!.reversed.toList();
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                // Handle null posterPath or title
                final posterUrl = movie.posterPath != null
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : null; // Fallback to null if no poster path
                final title = movie.title ?? 'No Title Available';
                final releaseDate = movie.releaseDate ?? 'Unknown Release Date';

                return ListTile(
                  leading: posterUrl != null
                      ? Image.network(
                          posterUrl,
                          fit: BoxFit.cover,
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to local asset if image fails to load
                            return Image.asset(
                              'lib/assets/REALFC logo copy.png',
                              fit: BoxFit.cover,
                              width: 50,
                            );
                          },
                        )
                      : Image.asset(
                          'lib/assets/REALFC logo copy.png', // Show local asset if posterUrl is null
                          fit: BoxFit.cover,
                          width: 50,
                        ),
                  title: Text(
                    title,
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: Text(
                    'Release date: $releaseDate',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
