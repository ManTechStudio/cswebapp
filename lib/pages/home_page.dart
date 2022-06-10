import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cswebapp/bloc/event.dart';
import 'package:cswebapp/constants.dart';
import '../services/api.dart';
import 'detail_page.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  Home({Key? key, Map? data, int? index})
      : i = index,
        data = data,
        super(key: key);
  int? i = 0;
  Map? data = {};

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int index;
  late Map data;
  @override
  void initState() {
    index = widget.i!;
    data = widget.data!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      (index != 1)
          ? Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              height: 60,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Text("Category: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black)),
                            Text("${SECTIONS[index - 1]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.red)),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<int>(
                          elevation: 5,
                          value: data["cpage"],
                          alignment: Alignment.center,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(color: Colors.black),
                          underline: Container(height: 2, color: Colors.black),
                          onChanged: (int? newValue) {
                            if (data["cpage"] != newValue) {
                              print(newValue);
                              PAGENOBLOC.eventSink.add(PageNoChange(newValue!));
                            }
                          },
                          items: <int>[
                            for (int j = 0; j < data["pages"]; j++) j
                          ].map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value + 1,
                              child: Text("Page: ${value + 1}"),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ))
          : SizedBox(height: 10),
      ((data["list"]).length != 0)
          ? GestureDetector(
              onTap: () {
                print(index);
                Map m = {};
                m["index1"] = index;
                m["data"] = (data);
                m["index2"] = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Details(map: m),
                  ),
                );
              },
              child: Container(

                  //height: MediaQuery.of(context).size.height/2.5,
                  child: Column(children: [
                Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    height: MediaQuery.of(context).size.height / 4,
                    child: CachedNetworkImage(
                      imageUrl: (data["list"])[0]["image"],
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
                ListTile(
                  isThreeLine: true,
                  title: Text(
                    "${(data["list"])[0]["title"]}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Html(data: "${(data["list"])[0]["excerpt"]}"),
                ),
                Row(children: [
                  IconButton(
                    icon: Icon(Icons.bookmark_outline),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share(' ${(data["list"])[0]["link"]}');
                    },
                  ),
                ]),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.black,
                )
              ])),
            )
          : Text("No data"),
      for (int i = 2; i <= (data["list"]).length; i++)
        Column(
          children: [
            GestureDetector(
              onTap: () {
                print(index);
                Map m = {};
                m["index1"] = index;
                m["data"] = (data);
                m["index2"] = i - 1;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Details(map: m),
                  ),
                );
              },
              child: Row(children: [
                Container(
                    margin: EdgeInsets.all(5),
                    width: 120,
                    child: CachedNetworkImage(
                      imageUrl: (data["list"][i - 1]["image"]),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
                SizedBox(width: 10),
                Flexible(
                  child: Text("${(data["list"])[i - 1]["title"]}",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.black,
            ),
          ],
        ),
      SizedBox(
        height: 10,
      ),
    ]));
  }
}
