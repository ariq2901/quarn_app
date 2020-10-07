import 'package:flutter/material.dart';
import 'package:quran_app/model/AlquranModel.dart';
import 'package:quran_app/viewModel/AlquranViewModel.dart';

class Alquran extends StatefulWidget {
  @override
  AlquranState createState() => AlquranState();
}

class AlquranState extends State<Alquran> {
  List dataAlquran = List();
  void getListSurat() {
    AlquranViewModel().getAlquran().then((value) {
      setState(() {
        dataAlquran = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getListSurat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alquran Aqri Jusuf"),
      ),
      body: dataAlquran == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemCount: dataAlquran.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(dataAlquran[i].nama),
            subtitle: Text("${dataAlquran[i].tipe} | ${dataAlquran[i].ayat} ayat"),
            trailing: Text(dataAlquran[i].asma),
            onTap: () {},
          );
        },
      )
    );
  }

}