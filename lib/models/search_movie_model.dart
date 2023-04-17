class SearchMovieModelSearch {


  String? Title;
  String? Year;
  String? imdbID;
  String? Type;
  String? Poster;

  SearchMovieModelSearch({
    this.Title,
    this.Year,
    this.imdbID,
    this.Type,
    this.Poster,
  });
  SearchMovieModelSearch.fromJson(Map<String, dynamic> json) {
    Title = json['Title']?.toString();
    Year = json['Year']?.toString();
    imdbID = json['imdbID']?.toString();
    Type = json['Type']?.toString();
    Poster = json['Poster']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Title'] = Title;
    data['Year'] = Year;
    data['imdbID'] = imdbID;
    data['Type'] = Type;
    data['Poster'] = Poster;
    return data;
  }
}

class SearchMovieModel {

  List<SearchMovieModelSearch?>? Search;
  String? totalResults;
  String? Response;

  SearchMovieModel({
    this.Search,
    this.totalResults,
    this.Response,
  });
  SearchMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      final v = json['Search'];
      final arr0 = <SearchMovieModelSearch>[];
      v.forEach((v) {
        arr0.add(SearchMovieModelSearch.fromJson(v));
      });
      Search = arr0;
    }
    totalResults = json['totalResults']?.toString();
    Response = json['Response']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (Search != null) {
      final v = Search;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['Search'] = arr0;
    }
    data['totalResults'] = totalResults;
    data['Response'] = Response;
    return data;
  }
}

