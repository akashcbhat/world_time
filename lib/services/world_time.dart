import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  late String location;
  late String time;
  late String flag;
  late String url;
  bool isDaytime=true;


  WorldTime({required this.location,required this.flag,required this.url});

  Future <void> getTime() async
  {

    try {
      Uri uri= Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response= await get(uri);
      Map data=jsonDecode(response.body);

      String datetime=data['datetime'];
      String offset=data['utc_offset'].substring(0,3);

      DateTime now=DateTime.parse(datetime);
      now=now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour <18 ? true : false;

      now = now.add(Duration(minutes: 30));

      time=DateFormat.jm().format(now);
    }
    catch (e){
      print('caught error:$e');
      time='could not get time data';

    }
  }

}


