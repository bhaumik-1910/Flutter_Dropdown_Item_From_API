import 'dart:convert';
import 'dart:io';

import 'package:counter_app/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropdownItemFromAPI extends StatefulWidget {
  const DropdownItemFromAPI({super.key});
  @override
  State<DropdownItemFromAPI> createState() => _DropdownItemFromAPI();
}

class _DropdownItemFromAPI extends State<DropdownItemFromAPI> {

  Future<List<DropdownItemsModel>> getPost() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsModel(
              userId: map['userId'], id: map['id'], title: map['title']);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  var selectValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 112, 59, 209),
        centerTitle: true,
        title: Text(
          'Dropdown Item From API',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<DropdownItemsModel>>(
                future: getPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      value: selectValue,
                      dropdownColor: Colors.blueAccent,
                      isExpanded: true,
                        hint: Text("Select An item"),
                        items: snapshot.data!.map((e) {
                          return DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(e.title),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectValue = value;
                          });
                        });
                  } else if (snapshot.hasError) {
                    return Text("Error:${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
