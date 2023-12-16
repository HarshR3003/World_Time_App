import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; //location name
  String time = ''; //time at there
  String flag; //url of an asset flag icon
  String url; //location url for api endpoint
  bool isDay = true; //Day or Night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getData() async {
    try{
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String dayTime = data['datetime'];
      List offset = [data['utc_offset'].substring(1,3), data['utc_offset'].substring(4,6)];
      DateTime now = DateTime.parse(dayTime);
      now = now.add(Duration(hours: int.parse(offset[0]), minutes: int.parse(offset[1])));
      isDay = (now.hour>5 && now.hour<17)?true:false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Error found: $e');
      time = 'Not a valid time zone, please correct the spelling or enter some valid zone';
    }
  }
}