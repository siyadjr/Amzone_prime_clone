import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetails extends StatelessWidget {
  final String description;
  final String genres;
  final double rating;
  final String releaseYear;
  final String duration;

  const MovieDetails({
    super.key,
    required this.description,
    required this.genres,
    required this.rating,
    required this.releaseYear,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 4),
          Text(
            genres,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.5,
              ),
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 4),
          Text(
            'IMDb $rating',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$releaseYear $duration min',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
