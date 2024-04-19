import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/additional_info_items.dart';
import 'package:weather_app/hourly_forecast_items.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async{
    try{
      String cityName = 'Klang';

      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'
        ),
      );

      final data = jsonDecode(res.body);

      if(data['cod'] != '200') {
        throw 'An unexpected error occurred!';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },

            icon: const Icon(Icons.refresh)
          ),
        ],
      ),

      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator.adaptive()
            );
          }

          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString())
            );
          }

          final data = snapshot.data!;
          final weatherCity = data['city']['name'];
          final weatherCountry = data['city']['country'];

          final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final celciusTemp = currentTemp - 273.15;

          final currentSky = currentWeatherData['weather'][0]['main'];

          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];

          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Main Card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
              
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10, 
                        sigmaY: 10
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              '$weatherCity, $weatherCountry',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),

                            Text(
                              '${celciusTemp.toStringAsPrecision(2)} °C',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    
                            const SizedBox(height: 15),
                      
                            Icon(
                              currentSky != 'Clouds' || currentSky == 'Rain' 
                                ? Icons.beach_access_outlined
                                : Icons.cloud, 
                              size: 64,
                            ),
                    
                            const SizedBox(height: 15),
                      
                            Text(
                              currentSky,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
        
              //Hourly Forecast Card
              const Text(
                'Hourly Forecast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 10),
              
              /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < 39; i++) 
                      HourlyForecastItem(
                        time: data['list'][i + 1]['dt'].toString(),
                        icon: data['list'][i + 1]['weather'][0]['main'] == 'Clouds' || data['list'][i + 1]['weather'][0]['main'] == 'Rain' ? Icons.beach_access_outlined : Icons.cloud,
                        temperature: data['list'][i + 1]['main']['temp'].toString(),
                      ),
                  ],
                ),
              ),*/


              //Using ListView to make up lazy load
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final hourlyForecast = data['list'][index + 1];
                    
                    final hourlySky = data['list'][index + 1]['weather'][0]['main'];

                    final hourlyTemp = hourlyForecast['main']['temp'];
                    final hourlyCelciusTemp = hourlyTemp - 273.15;

                    final time = DateTime.parse(hourlyForecast['dt_txt']);
              
                    return HourlyForecastItem(
                      time: DateFormat.jm().format(time), 
                      icon: hourlySky != 'Clouds' || hourlySky == 'Rain' 
                            ? Icons.beach_access_outlined
                            : Icons.cloud, 
                      temperature: '${hourlyCelciusTemp.toStringAsPrecision(2)} °C',
                    );
                  }
                ),
              ),
        
              const SizedBox(height: 20),
        
              //Additional Info Card
              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddInfoItems(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: currentHumidity.toString(),
                  ),
                  AddInfoItems(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: currentWindSpeed.toString(),
                  ),
                  AddInfoItems(
                    icon: Icons.beach_access,
                    label: 'Pressure',
                    value: currentPressure.toString(),
                  ),
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}