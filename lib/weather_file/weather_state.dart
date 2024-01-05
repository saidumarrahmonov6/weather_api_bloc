part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {

}
class WeatherLoading extends WeatherState{

}
class WeatherSuccess extends WeatherState{
  final Weather weather;

  WeatherSuccess(this.weather);
}
class WeatherError extends WeatherState{
  final String message;

  WeatherError(this.message);
}