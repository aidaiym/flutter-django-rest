import 'package:flutter/material.dart';
import 'search_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<dynamic> bookList = [];

  void getBooks() async {
    String url = 'http://192.168.176.113:8000/api/books/?format=json';
    http.Response response = await http.get(Uri.parse(url));
    final val = response.body;
    List<dynamic> data = jsonDecode(val);
    setState(() {
      data.forEach((value) {
        bookList.add(value);
        print(bookList);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Django BACKEND data"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: bookList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildResultCard(bookList[index]);
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Text("Search Books"),
          ),
        ],
      ),
    );
  }
}

Widget buildResultCard(data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text(data['name']),
          subtitle: Text("Rs.${data['price']}"),
        ),
        Divider(color: Colors.black)
      ],
    ),
  );
}
