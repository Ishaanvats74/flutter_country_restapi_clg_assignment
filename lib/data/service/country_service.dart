

import '../model/country.dart';
import '../provider/country_api.dart';

class CountryService {
  final CountryApi _api = CountryApi();

  Future<List<Country>> getAllCountries() async {
    final result = await _api.getAllCountries();

    if (result == null) {
      throw Exception("Failed to fetch countries");
    }

    return result;
  }
}