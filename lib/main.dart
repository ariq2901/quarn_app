import 'package:flutter/material.dart';
 import 'dart:convert';
 import 'package:http/http.dart' as http;
 import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: 'Alqur\'an xii rpl',
    home: HalamanJson(),
  ));
}

class HalamanJson extends StatefulWidget {
  @override
  _HalamanJsonState createState() => _HalamanJsonState();
}

class _HalamanJsonState extends State<HalamanJson> {
  int nomor;
  List dataDariJson;

  Future ambilData() async {
    http.Response hasil = await http.get(
      Uri.encodeFull(
        "https://al-quran-8d642.firebaseio.com/data.json?print=pretty",
      ),
      headers: {"Accept" : "application/json"}
    );
    this.setState(() {
      dataDariJson = json.decode(hasil.body);
    });
  }

  @override 
  void initState() {
    this.ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Al-Qur\'an XII RPL'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dataDariJson == null ? 0 : dataDariJson.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(dataDariJson[i]['nama'] ?? ''),
              subtitle: Text(dataDariJson[i]['type'] +
                ' | ' +
                dataDariJson[i]['ayat'].toString() +
                " ayat" ?? ""),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      var dataDariJson2 = dataDariJson[i];
                      return DetailAlQuran(
                        nomor: dataDariJson2['nomor'],
                        nama: dataDariJson2['nama']
                      );
                    }
                  )
                );
              },
            );
          },
        )
      ),
    );
  }
}

class DetailAlQuran extends StatefulWidget {
  final String nomor;
  final String nama;

  DetailAlQuran({this.nomor, this.nama});
  @override
  _DetailAlQuran createState() => _DetailAlQuran();
}

class _DetailAlQuran extends State<DetailAlQuran> {
  List dataAlquranJSON;

  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(
            "https://al-quran-8d642.firebaseio.com/surat/${widget.nomor}.json?print=pretty"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataAlquranJSON = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata();
  }

  // final String data = ambildata();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" ${widget.nama}"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dataAlquranJSON == null ? 0 : dataAlquranJSON.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(dataAlquranJSON[i]['ar'] ?? ""),
            );
          },
        ),
      ),
    );
  }
}