import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/searched_movies.dart';

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
  bool _isSearching = false;

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
      _isSearching = true; 
    });
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        _filterMovies(_searchController.text);
      } else {
        setState(() {
          _filteredMovies = [];
          _isSearching = false; 
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
      _isSearching = false; 
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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              if (_isSearching)
                const Center(
                    child: CircularProgressIndicator(color: Colors.white))
              else
                _filteredMovies.isNotEmpty
                    ? SearchedMovies(filteredMovies: _filteredMovies)
                    : _searchController.text.isNotEmpty
                        ? const Center(
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),

              const SizedBox(height: 20),

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
                  onPressed: () {},
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

  Widget _buildGenreButton(String genre) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 36, 40, 59),
      ),
      onPressed: () {},
      child: Text(genre, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildFeaturedCollection(String language) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(language, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: () {},
    );
  }
}

