import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

class Country {
  Name? name;
  List<String>? capital;
  List<String>? continents;
  Flags? flags;

  Country({this.name, this.capital, this.continents, this.flags});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"] == null ? null : Name.fromJson(json["name"]),
      capital: json["capital"] == null
          ? []
          : List<String>.from(json["capital"].map((x) => x)),
      continents: json["continents"] == null
          ? []
          : List<String>.from(json["continents"].map((x) => x)),
      flags:
          json["flags"] == null ? null : Flags.fromJson(json["flags"]),
    );
  }
}

class Flags {
  String? png;

  Flags({this.png});

  factory Flags.fromJson(Map<String, dynamic> json) =>
      Flags(png: json["png"]);
}

class Name {
  String? common;

  Name({this.common});

  factory Name.fromJson(Map<String, dynamic> json) =>
      Name(common: json["common"]);
}