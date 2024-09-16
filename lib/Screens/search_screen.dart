import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/watch.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late Future<List<Movie>> trendingMovies;
  List<Movie> _filteredMovies = [];
  Timer? _debounce;
  bool _isSearching = false; // Added flag to track search state

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    trendingMovies = Api().getTrendingMovie();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() {
      _isSearching = true; // Set searching to true
    });
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        _filterMovies(_searchController.text);
      } else {
        setState(() {
          _filteredMovies = [];
          _isSearching = false; // Reset searching state
        });
      }
    });
  }

  void _filterMovies(String query) async {
    final movies = await trendingMovies;
    final filtered = movies.where((movie) {
      return movie.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredMovies = filtered;
      _isSearching = false; // Reset searching state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white),
            onPressed: () {
              // Implement cast functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // Implement profile functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search by actor, title..',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  suffixIcon: const Icon(Icons.mic, color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Display Loading Indicator if searching
              if (_isSearching)
                const Center(
                    child: CircularProgressIndicator(color: Colors.white))
              else
                // Display Search Results
                _filteredMovies.isNotEmpty
                    ? Column(
                        children: _filteredMovies.map((movie) {
                          return ListTile(
                              title: Text(movie.title,
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(movie.releaseDate,
                                  style:
                                      const TextStyle(color: Colors.white70)),
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
                                      duration:
                                          '139', // Add the correct duration
                                    ),
                                  ),
                                );
                                ;
                              });
                        }).toList(),
                      )
                    : _searchController.text.isNotEmpty
                        ? const Center(
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),

              const SizedBox(height: 20),

              // Genres Section
              const Text(
                'Genres',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                children: [
                  _buildGenreButton('Action and adventure'),
                  _buildGenreButton('Anime'),
                  _buildGenreButton('Comedy'),
                  _buildGenreButton('Documentary'),
                  _buildGenreButton('Drama'),
                  _buildGenreButton('Fantasy'),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  onPressed: () {
                    // Implement see more functionality here
                  },
                  child: const Text(
                    'See more',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Featured Collections Section
              const Text(
                'Featured collections',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              _buildFeaturedCollection('Hindi'),
              _buildFeaturedCollection('English'),
              _buildFeaturedCollection('Telugu'),
              _buildFeaturedCollection('Tamil'),
              _buildFeaturedCollection('Malayalam'),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  onPressed: () {
                    // Implement see more functionality here
                  },
                  child: const Text(
                    'See more',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 49,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build genre buttons
  Widget _buildGenreButton(String genre) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 36, 40, 59),
      ),
      onPressed: () {
        // Handle genre tap
      },
      child: Text(genre, style: const TextStyle(color: Colors.white)),
    );
  }

  // Helper method to build featured collections
  Widget _buildFeaturedCollection(String language) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(language, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: () {
        // Handle collection tap
      },
    );
  }
}
