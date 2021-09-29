import 'package:map_search/models/search_result.dart';

import 'api_provider.dart';

class SearchApi {
  ApiProvider _provider = ApiProvider();

  static String buildSearchUrl(String searchInput) {
    return "https://nominatim.openstreetmap.org/search?q=$searchInput&format=json";
  }

  Future<SearchResult> fetchSearchResults(String searchInput) async {
    final response = await _provider.get(buildSearchUrl(searchInput));
    if (response.isEmpty) throw Exception("Not found");
    return SearchResult.fromJson(response[0]);
  }
}
