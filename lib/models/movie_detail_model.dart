class MovieDetailModelRatings {


  String? Source;
  String? Value;

  MovieDetailModelRatings({
    this.Source,
    this.Value,
  });
  MovieDetailModelRatings.fromJson(Map<String, dynamic> json) {
    Source = json['Source']?.toString();
    Value = json['Value']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Source'] = Source;
    data['Value'] = Value;
    return data;
  }
}

class MovieDetailModel {


  String? Title;
  String? Year;
  String? Rated;
  String? Released;
  String? Runtime;
  String? Genre;
  String? Director;
  String? Writer;
  String? Actors;
  String? Plot;
  String? Language;
  String? Country;
  String? Awards;
  String? Poster;
  List<MovieDetailModelRatings?>? Ratings;
  String? Metascore;
  String? imdbRating;
  String? imdbVotes;
  String? imdbID;
  String? Type;
  String? DVD;
  String? BoxOffice;
  String? Production;
  String? Website;
  String? Response;

  MovieDetailModel({
    this.Title,
    this.Year,
    this.Rated,
    this.Released,
    this.Runtime,
    this.Genre,
    this.Director,
    this.Writer,
    this.Actors,
    this.Plot,
    this.Language,
    this.Country,
    this.Awards,
    this.Poster,
    this.Ratings,
    this.Metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbID,
    this.Type,
    this.DVD,
    this.BoxOffice,
    this.Production,
    this.Website,
    this.Response,
  });
  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    Title = json['Title']?.toString();
    Year = json['Year']?.toString();
    Rated = json['Rated']?.toString();
    Released = json['Released']?.toString();
    Runtime = json['Runtime']?.toString();
    Genre = json['Genre']?.toString();
    Director = json['Director']?.toString();
    Writer = json['Writer']?.toString();
    Actors = json['Actors']?.toString();
    Plot = json['Plot']?.toString();
    Language = json['Language']?.toString();
    Country = json['Country']?.toString();
    Awards = json['Awards']?.toString();
    Poster = json['Poster']?.toString();
    if (json['Ratings'] != null) {
      final v = json['Ratings'];
      final arr0 = <MovieDetailModelRatings>[];
      v.forEach((v) {
        arr0.add(MovieDetailModelRatings.fromJson(v));
      });
      Ratings = arr0;
    }
    Metascore = json['Metascore']?.toString();
    imdbRating = json['imdbRating']?.toString();
    imdbVotes = json['imdbVotes']?.toString();
    imdbID = json['imdbID']?.toString();
    Type = json['Type']?.toString();
    DVD = json['DVD']?.toString();
    BoxOffice = json['BoxOffice']?.toString();
    Production = json['Production']?.toString();
    Website = json['Website']?.toString();
    Response = json['Response']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Title'] = Title;
    data['Year'] = Year;
    data['Rated'] = Rated;
    data['Released'] = Released;
    data['Runtime'] = Runtime;
    data['Genre'] = Genre;
    data['Director'] = Director;
    data['Writer'] = Writer;
    data['Actors'] = Actors;
    data['Plot'] = Plot;
    data['Language'] = Language;
    data['Country'] = Country;
    data['Awards'] = Awards;
    data['Poster'] = Poster;
    if (Ratings != null) {
      final v = Ratings;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['Ratings'] = arr0;
    }
    data['Metascore'] = Metascore;
    data['imdbRating'] = imdbRating;
    data['imdbVotes'] = imdbVotes;
    data['imdbID'] = imdbID;
    data['Type'] = Type;
    data['DVD'] = DVD;
    data['BoxOffice'] = BoxOffice;
    data['Production'] = Production;
    data['Website'] = Website;
    data['Response'] = Response;
    return data;
  }
}

