import 'dart:convert';
import 'package:http/http.dart';
import 'package:cswebapp/constants.dart';

class API2 {
  Future<Map> getData(int index) async {
    try {
      // var request = Request('GET', Uri.parse('http://chambalsandesh.com/cs/wp-json/wp/v2/posts/'));
      Response response = await get(
          Uri.parse('http://chambalsandesh.com/cs/wp-json/wp/v2/categories/'));

      if (response.statusCode == 200) {
        Map m = {};
        List data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          m[data[i]["name"]] = data[i]["id"];
        }

        return m;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    return ({});
  }
}
