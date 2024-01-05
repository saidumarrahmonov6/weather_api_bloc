import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../api/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
    void getWeather() async {
      Dio dio = Dio();
      emit(WeatherLoading());
      try {
      var response = await dio.get("http://api.weatherapi.com/v1/current.json?key=402f7b21b363478f84a94851232711&q=Fergana");
      if(response.statusCode == 200){
        emit(WeatherSuccess(Weather.fromJson(response.data)));
      } else {
        emit(WeatherError("Xatolik"));
      }} catch (e){
        print(e.toString());
      }
    }
}
