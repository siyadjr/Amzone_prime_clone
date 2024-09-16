import 'dart:async'; // Import the timer package
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/suggested_movies.dart';

class TopWidget extends StatefulWidget {
  final List<Movie> trendingMovies;
  TopWidget({
    required this.trendingMovies,
    super.key,
  });

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.trendingMovies.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 69,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'lib/assets/Amazone logo.png',
                color: Colors.white,
                height: 90,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.cast,
                    color: Color.fromARGB(255, 153, 152, 152),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 60, 103, 138),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colors.black,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  'Movies',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey), // White border
                ),
                child: const Text(
                  'TV shows',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey), // White border
                ),
                child: const Text(
                  'Live TV',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 260,
          child: PageView.builder(
            itemCount: widget.trendingMovies.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return SuggestedMoviesCard(
                index: index,
                movie: widget.trendingMovies[index], // Correct casting
              );
            },
          ),
        ),
      ],
    );
  }
}
