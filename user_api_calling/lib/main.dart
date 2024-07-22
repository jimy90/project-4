import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_api_calling/sample_file.dart';

void main() => runApp(MaterialApp(
      title: "Api Calling",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SampleFile> samplefile = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 145, 241),
      ),
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                itemCount: samplefile.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 243, 236, 236),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                          index,
                          'ID: ',
                          samplefile[index].id.toString(),
                        ),
                        getText(
                          index,
                          'Name: ',
                          samplefile[index].name.toString(),
                        ),
                        getText(
                          index,
                          'Email: ',
                          samplefile[index].email.toString(),
                        ),
                        getText(
                          index,
                          'Website: ',
                          samplefile[index].website.toString(),
                        ),
                        getText(
                          index,
                          'Compny Name: ',
                          samplefile[index].company.toString(),
                        ),
                        getText(index, 'Address: ',
                            "${samplefile[index].address?.suite??''},${samplefile[index].address?.city??''}-${samplefile[index].address?.zipcode??''}")
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Text getText(int index, String fildName, String content) {
    return Text.rich((TextSpan(children: [
      TextSpan(
          text: fildName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      TextSpan(
          text: content,
          style: TextStyle(
            fontSize: 16,
          )),
      // TextSpan(text: index,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
    ])));
  }

  Future<List<SampleFile>> getdata() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplefile.add(SampleFile.fromJson(index));
      }

      return samplefile;
    } else {
      return samplefile;
    }
  }
}
