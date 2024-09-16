import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/watch.dart';

class AmazoneOriginalSeries extends StatefulWidget {
  const AmazoneOriginalSeries({super.key});

  @override
  State<AmazoneOriginalSeries> createState() => _AmazoneOriginalSeriesState();
}

class _AmazoneOriginalSeriesState extends State<AmazoneOriginalSeries> {
  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovie(); // Fetching movies from the API
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Amazon Original Series',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 300, // Adjust the height as needed
          child: FutureBuilder<List<Movie>>(
            future: trendingMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final movies = snapshot.data!; // The list of movies

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
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
                              width: 180,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}', // Display movie poster
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie.title, // Show movie title
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis, // Avoid overflow
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }
}
