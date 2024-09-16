import 'package:flutter/material.dart';
import 'package:netflix_clone/Screens/live_tv_screen.dart';
import 'package:netflix_clone/Screens/movie_screen.dart';
import 'package:netflix_clone/Screens/search_screen.dart';
import 'package:netflix_clone/Screens/tvshow_screen.dart';

import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/amazone_original_series.dart';
import 'package:netflix_clone/widgets/latest_movies.dart';
import 'package:netflix_clone/widgets/popular_shows.dart';
import 'package:netflix_clone/widgets/top_widget.dart';
import 'package:netflix_clone/widgets/watch_in_language.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentIndex = 0;
  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovie();
  }

  final List<Widget> _screens = [
    const MovieScreen(),
    const TvshowScreen(),
    const LiveTvScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildScreen(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'Movies',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tv),
                  label: 'TV Shows',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv),
                  label: 'Live TV',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  label: 'Search',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen() {
    if (_currentIndex == 0) {
      return HomeScreen(trendingMovies: trendingMovies);
    } else {
      return _screens[_currentIndex - 1];
    }
  }
}

class HomeScreen extends StatelessWidget {
  final Future<List<Movie>> trendingMovies;

  const HomeScreen({required this.trendingMovies, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: trendingMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading trending movies'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No trending movies available'));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TopWidget(trendingMovies: snapshot.data!),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PopularShows(),
                      SizedBox(height: 20), // Added space between sections
                      WatchInLanguage(),
                      SizedBox(height: 20), // Added space between sections
                      AmazoneOriginalSeries(),
                      SizedBox(height: 20), // Added space between sections
                      LatestMovies(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
