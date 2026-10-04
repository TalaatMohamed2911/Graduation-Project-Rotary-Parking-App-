import 'dart:convert';
import 'package:http/http.dart' as http;

class SlotsNumbers {
  static Stream getSlots() => Stream.periodic(const Duration(milliseconds: 250))
      .asyncMap((event) => getFreeSlots());

  static Future getFreeSlots() async {
    const url = // 'https://worldtimeapi.org/api/timezone/Africa/Cairo';
        'https://render-two.vercel.app/buildings?id=1&id=2&id=3&id=4&id=5';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    // print(body);
    return body;
  }
}
