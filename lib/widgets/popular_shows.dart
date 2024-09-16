import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart'; // Ensure you're importing your Movie model
import 'package:netflix_clone/widgets/watch.dart';

class PopularShows extends StatefulWidget {
  const PopularShows({super.key});

  @override
  State<PopularShows> createState() => _PopularShowsState();
}

class _PopularShowsState extends State<PopularShows> {
  late Future<List<Movie>> popularMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = Api().getTrendingMovie(); // Fetch the popular movies
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              const Text(
                'Watch for Free - Most popular shows',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200, // Adjust the height as needed
          child: FutureBuilder<List<Movie>>(
            future: popularMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading movies'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No popular movies available'));
              } else {
                final movies = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GestureDetector(
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
                                    releaseYear:
                                        movie.releaseDate.split('-')[0],
                                    duration: '139', // Add the correct duration
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 120, // Adjust the width if needed
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width:
                                120, // Match the width of the movie container
                            child: Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow
                                  .ellipsis, // Ellipsis for long titles
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
