import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_bloc/models/models.dart';

class WeatherApiClient {
  static const baseURL = 'www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl =
        Uri.https('$baseURL', 'api/location/search', {"query": city});
    final locationResponse = await this.httpClient.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;

    return (locationJson.first)['woeid'];
  }

  Future<WeatherModel> fetchWeather(int locationId) async {
    final weatherUrl = Uri.https('$baseURL', '/api/location/$locationId');
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);

    return WeatherModel.fromJson(weatherJson);
  }
}
