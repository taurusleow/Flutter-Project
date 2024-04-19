import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //Location name for the UI
  late String time; //Location of the time
  late String flag; //URL of a flag icon
  late String url; //URL of the Location API endpoint
  late bool isDayTime; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try{
      var api = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      Response response = await http.get(api);
      Map data = jsonDecode(response.body);

      //Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //Crete DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
    
      //Set the time property
      //1st Method: time = now.toString();
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);

    }catch (e) {
      print('Caught Error: $e');
      time = 'Could not get time data!';
    }

    //Test print data out
    // print(datetime);
    // print(offset);

    //print(data);

    // Using dummy url to get the data
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    // Response response = await http.get(url);
    // Map data = jsonDecode(response.body);

    // print(data);
    // print(data['title']);

    //   Simulate network request for a username
    //   await Future.delayed(Duration(seconds: 3), () {
    //     print('Yoshi');
    //   });

    //   await Future.delayed(Duration(seconds: 2), () {
    //     print('Abc');
    //   });
  }
}

