import 'package:meta/meta.dart';
import 'package:weather_bloc/models/models.dart';
import 'package:weather_bloc/repositories/repositories.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<WeatherModel> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);

    return weatherApiClient.fetchWeather(locationId);
  }
}
