import 'package:flutter/material.dart';
import 'package:cswebapp/pages/home_page.dart';
import 'package:cswebapp/services/api.dart';

class Loading extends StatelessWidget {
  Loading({Key? key, int? index, int? page})
      : i = index,
        page = page,
        super(key: key);
  int? i = 0;
  int? page = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API().getData(i!, page!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              print((snapshot.data as Map)["pages"]);
              return Home(data: snapshot.data as Map, index: i);
            }
          }
        });
  }
}
