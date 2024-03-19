import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api/api/weather.dart';
import 'package:weather_api/weather_file/weather_cubit.dart';

void main(){
  runApp(MaterialApp(home: BlocProvider(
  create: (context) => WeatherCubit(),
  child: MyApp(),
), debugShowCheckedModeBanner:  false,));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

 class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WeatherCubit>(context).getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit , WeatherState>(
        builder: (context , state){
          if(state is WeatherInitial){
            return SizedBox();
          } else if(state is WeatherLoading){
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Weather Api"),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if(state is WeatherSuccess) {
            return Column(
                children: [
                  Center(
                      child: Column(children: [
                        SizedBox(height: 15,),
                        Center(child: Text(state.weather.current?.lastUpdated
                            ?.toString() ?? "Nomalum", style: TextStyle(
                            fontSize: 30),)),
                        SizedBox(height: 15,),
                        Text(state.weather.location?.region.toString() ??
                            "Nomalum",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight
                              .bold, color: Colors.white),),
                        //pasdagi Row haroratni korsatadigan block
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.weather.current?.tempC.toString() ??
                                "Nomalum", style: TextStyle(fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent),),
                            Text("o", style: TextStyle(fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent)),
                            Text("C", style: TextStyle(fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent)),
                          ],),
                      ])
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              border: Border.all(width: 1, color: Colors.white24),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${state.weather.current?.humidity?.toString()??"Nomalum"}%",  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
                                Text("Namlik foizi", style: TextStyle(fontSize: 20),)
                              ],
                            ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 10, left: 5),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              border: Border.all(width: 1, color: Colors.white24),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.weather.current?.gustKph?.toString()??"Nomalum", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
                                Text("Shamol km/h ", style: TextStyle(fontSize: 20),)
                              ],
                            ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      border: Border.all(width: 1, color: Colors.white24),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("His qilinishi : ${state.weather.current?.feelslikeC.toString()??"Nomalum"}⁰", style: TextStyle(fontSize: 40),),
                  ),
                ]
            );
          } else if(state is WeatherError){
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text("Nomalum xatolik"),
            );
          }
        },
      ),
    );
  }
}
