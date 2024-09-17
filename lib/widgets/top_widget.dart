import 'package:flutter/material.dart';
import 'package:netflix_clone/model/movies.dart';
import 'package:netflix_clone/widgets/suggested_movies.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopWidget extends StatelessWidget {
  final List<Movie> trendingMovies;

  TopWidget({
    required this.trendingMovies,
    super.key,
  });

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
                  SizedBox(width: 18),
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
              const SizedBox(width: 10),
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
              const SizedBox(width: 5),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  'TV shows',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 5),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
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
          child: CarouselSlider.builder(
            itemCount: trendingMovies.length,
            itemBuilder: (context, index, realIndex) {
              return SuggestedMoviesCard(
                index: index,
                movie: trendingMovies[index],
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
        ),
      ],
    );
  }
}
