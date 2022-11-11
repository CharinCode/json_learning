import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ep1/add.dart';
import 'package:flutter_ep1/fileprocess.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Map> dataList = [];

class _MyHomePageState extends State<MyHomePage> {
  Future<String> _getfile() async {
    DataFileProcess dataFile = DataFileProcess();
    String dataStr = await dataFile.readData();

    var dataJSON;
    if (dataList.length == 0 && dataStr != null && dataStr != '{}') {
      dataJSON = jsonDecode(dataStr);
      for (var item in dataJSON) {
        Map<String, dynamic> dataMap = {
          'id': item['id'],
          'msg': item['msg'],
        };
        dataList.add(dataMap);
      }
    }
    return 'ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Processing'),
      ),
      body: FutureBuilder(
        future: _getfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    child: ListTile(title: Text("${dataList[index]['msg']}")),
                  );
                }));
          } else {
            return Center(
              child: Column(
                children: [CircularProgressIndicator()],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return AddMessage();
          })));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
