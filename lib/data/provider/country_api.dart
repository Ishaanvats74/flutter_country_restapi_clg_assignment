import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/country.dart';


class CountryApi {
  final String baseUrl = 'https://restcountries.com/v3.1/all?fields=name,capital,continents,flags';

  Future<List<Country>?> getAllCountries() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return countryFromJson(
          const Utf8Decoder().convert(response.bodyBytes),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

