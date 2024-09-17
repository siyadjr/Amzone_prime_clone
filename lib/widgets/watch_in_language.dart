import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/watch.dart';

class WatchInLanguage extends StatefulWidget {
  const WatchInLanguage({super.key});

  @override
  State<WatchInLanguage> createState() => _WatchInLanguageState();
}

class _WatchInLanguageState extends State<WatchInLanguage> {
  late Future<List<Movie>> trendingMovies; // Future for trending movies

  final List<String> languages = [
    'Hindi',
    'English',
    'Telugu',
    'Tamil',
    'Malayalam'
  ];

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovie(); // Fetch trending movies
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Add this line
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Watch in Your Language',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontStyle: FontStyle.normal),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200, 
          child: FutureBuilder<List<Movie>>(
            future: trendingMovies, 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No movies available.'));
              } else {
                final movies = snapshot.data!;
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
                              width: 250,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}', // Movie poster URL
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            languages[index %
                                languages
                                    .length], // Alternate between languages
                            style: const TextStyle(color: Colors.white),
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
