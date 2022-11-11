import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ep1/fileprocess.dart';
import 'package:flutter_ep1/wellcome.dart';

class AddMessage extends StatefulWidget {
  const AddMessage({
    super.key,
  });

  @override
  State<AddMessage> createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
  String messageStr = '';

  Future<void> _addMessage() async {
    DataFileProcess dataFile = DataFileProcess();
    List<Map> dataList = []; // สร้างไว้เพื่อแปลง map ไปเป็น list

    // Exit data
    String dataStr = await dataFile.readData();
    var dataJson = jsonDecode(dataStr);

    for (var item in dataJson) {
      Map<String, dynamic> dataMap = {
        'id': item['id'],
        'msg': item['msg'],
      };
      dataList.add(dataMap);
    }

    // new data
    Map<String, dynamic> dataMap = {
      'id': '0',
      'msg': messageStr
    }; // สร้างเพื่อเก็บข้อมูลเป็นmap

    dataList.add(dataMap); // แปลงmap เป็น list

    var datajson_new = jsonEncode(dataList); // แปลง list เป็น json
    dataFile.writeData(datajson_new.toString());

    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return MyHomePage();
    })));
  }

  @override
  Widget build(BuildContext context) {
    TextField _message = TextField(
      decoration: InputDecoration(hintText: 'Enter message'),
      onChanged: (msg) {
        messageStr = msg;
      },
    );

    ElevatedButton _addbutton = ElevatedButton(
        onPressed: () {
          _addMessage();
        },
        child: Text('Add Message'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Message'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _message,
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [_addbutton],
              )
            ],
          ),
        ),
      ),
    );
  }
}
