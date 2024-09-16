import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/widgets/movie_details.dart';

class Watch extends StatelessWidget {
  final String movieName;
  final String description;
  final String posterPath;
  final String genres;
  final double rating;
  final String releaseYear;
  final String duration;

  const Watch({
    super.key,
    required this.movieName,
    required this.description,
    required this.posterPath,
    required this.genres,
    required this.rating,
    required this.releaseYear,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Cast and Profile Icon
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 69,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Movie Banner with Poster and Gradient
            Stack(
              children: [
                // Movie Poster
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent, // Start with transparent
                        Colors.black, // Transition to black at the bottom
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 1.0], // Adjust the position of the gradient
                    ),
                  ),
                ),
              ],
            ),
            // Movie Name and Buttons
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieName,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Watch Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor:
                            Colors.white, // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      child: const Text(
                        'Watch This Movie',
                        style: TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 16, // Text size
                          fontWeight: FontWeight.w600, // Bold text
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Icons Row with Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconWithLabel(Icons.add, 'Watchlist'),
                      _buildIconWithLabel(Icons.restart_alt, 'Reset'),
                      _buildIconWithLabel(Icons.thumb_up_sharp, 'Like'),
                      _buildIconWithLabel(Icons.thumb_down_sharp, 'Not for Me'),
                      _buildIconWithLabel(Icons.share, 'Share'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Movie Description
                  MovieDetails(
                    description: description,
                    genres: genres,
                    rating: rating,
                    releaseYear: releaseYear,
                    duration: duration,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
