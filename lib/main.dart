import 'package:flutter/material.dart';
import 'package:flutter_country_restapi/data/model/country.dart';
import 'package:flutter_country_restapi/data/service/country_service.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Country>? countries;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    try {
      final countryService = CountryService();
      countries = await countryService.getAllCountries();
    } catch (e) {
      debugPrint("Error loading countries: $e");
    }

    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries"),
        centerTitle: true,
      ),

      body: !isLoaded
          ? const Center(child: CircularProgressIndicator())
          : countries == null || countries!.isEmpty
              ? const Center(child: Text("No data found"))
              : SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      /// HEADER ROW
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Capital',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Continent',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Flag',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      const Divider(),

                      /// LIST
                      Expanded(
                        child: ListView.builder(
                          itemCount: countries!.length,
                          itemBuilder: (context, index) {
                            final country = countries![index];

                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    children: [
                                      /// NAME
                                      Expanded(
                                        child: Text(
                                          country.name?.common ?? 'No name',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      /// CAPITAL
                                      Expanded(
                                        child: Text(
                                          country.capital != null &&
                                                  country.capital!.isNotEmpty
                                              ? country.capital!.first
                                              : 'No capital',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      /// CONTINENT
                                      Expanded(
                                        child: Text(
                                          country.continents != null &&
                                                  country.continents!.isNotEmpty
                                              ? country.continents!.first
                                              : 'No continent',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      /// FLAG
                                      Expanded(
                                        child: country.flags?.png != null
                                            ? Image.network(
                                                country.flags!.png!,
                                                height: 30,
                                                fit: BoxFit.cover,
                                              )
                                            : const Icon(Icons.flag),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}