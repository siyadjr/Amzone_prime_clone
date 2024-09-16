class Movie {
  String title;
  String backDropPath;
  String originalTitle;
  String overView;
  String posterPath;
  String releaseDate;
  double voteAvarage;
  Movie(
      {required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overView,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAvarage});
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        backDropPath: json['backdrop_path'],
        originalTitle: json['original_title'],
        overView: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['media_type'],
        voteAvarage: json['vote_average']);
  }

}
