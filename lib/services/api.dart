import 'dart:convert';
import 'package:http/http.dart';
import 'package:cswebapp/constants.dart';

class API {
  Future<Map> getData(int index, int cpage) async {
    String format(String date) {
      List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      String s1 = date.substring(0, 10);
      String year = date.substring(0, 4);
      String month = months[int.parse(date.substring(5, 7)) - 1];
      String day = date.substring(8, 10);
      return "${day} ${month}, ${year} at ${date.substring(11)} IST";
    }

    try {
      // var request = Request('GET', Uri.parse('http://chambalsandesh.com/cs/wp-json/wp/v2/posts/'));
      Response response, response2;
      (index == 1)
          ? response = await get(
              Uri.parse('http://chambalsandesh.com/cs/wp-json/wp/v2/posts/'))
          : response = await get(Uri.parse(
              'http://chambalsandesh.com/cs/wp-json/wp/v2/posts/?categories=${S1[SECTIONS[index - 1]]}&&page=$cpage'));
      int page = 1;
      if (response.statusCode == 200) {
        List l = [];
        List data = jsonDecode(response.body);
        if (index != 1) {
          print("${S1[SECTIONS[index - 1]]}");
          Response response2 = await get(Uri.parse(
              'http://chambalsandesh.com/cs/wp-json/wp/v2/categories/${S1[SECTIONS[index - 1]]}'));
          Map m1 = jsonDecode(response2.body);
          print(m1.toString());
          page = ((m1["count"]) / 10).toInt() + 1;
        }

        for (int i = 0; i < data.length; i++) {
          Map m = {};
          m["id"] = data[i]["id"];
          m["title"] = data[i]["title"]["rendered"];
          print("${m["title"]}");
          m["categories"] = data[i]["categories"];
          m["content"] = data[i]["content"]["rendered"];

          try {
            m['image'] = data[i]["yoast_head_json"]["og_image"][0]["url"];
          } catch (e) {
            m["image"] = "null";
          }
          try {
            if (data[i]["excerpt"]["rendered"] != null)
              m['excerpt'] = data[i]["excerpt"]["rendered"];
          } catch (e) {
            m["excerpt"] = "";
          }

          m["date"] = format(data[i]["date"]);
          m["link"] = data[i]["guid"]["rendered"];
          //m["modified_date"] = data[i]["modified"];

          try {
            m['author'] =
                data[i]["yoast_head_json"]["twitter_misc"]["Written by"];
          } catch (e) {
            m["author"] = "Unknown";
          }
          l.add(m);
        }

        return {"list": l, "pages": page, "cpage": cpage};
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    return ({});
  }
}
