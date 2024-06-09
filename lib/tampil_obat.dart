import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:obat/form_inputobat.dart';

void main() {
  runApp(MaterialApp(
    home: tampildata_obat(),
  ));
}

class tampildata_obat extends StatefulWidget{

  @override
  State<tampildata_obat> createState() => _tampildata_obatState();
}

class _tampildata_obatState extends State<tampildata_obat> {
  List obatdata=[];
  Future<void> baca_data() async{
    String uri = "http://192.168.1.18/koneksiobat.php";
    try {
      final respon = await http.get(Uri.parse(uri));
      if(respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        print(data);
        setState(() {
          obatdata = data;
        });
        obatdata = data;
      }
    } catch (e) {
      print(e);
    }
  }

Future<void> hapus_obat(String xnama) async {
    String url = "http://192.168.1.18/hapus_obat.php";
    try {
      final respon = await http.post(
        Uri.parse(url),
        body: {"xnama": xnama},
      );

      if (respon.statusCode == 200) {
        print('berhasil dihapus');
        // Remove the item from the list and update the UI
        setState(() {
          obatdata.removeWhere((item) => item['xnama'] == xnama);
        });
      } else {
        print('Failed to delete data. Status code: ${respon.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
}
}

  @override
  void initState() {
    baca_data();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Listview data obat'), backgroundColor: Colors.blue[100],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 400 ,width: double.infinity, color: Colors.amber[50],
                child: ListView.builder(
                  itemCount: obatdata.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(obatdata[index]['nama_obat']+" -- "+obatdata[index]['satuan_obat']),
                      subtitle: Text(obatdata[index]['kode_obat']+" - "+obatdata[index]['jumlah_obat']+" - "+obatdata[index]['harga_obat']),
                      trailing: IconButton(
                        onPressed: () {
                          hapus_obat(obatdata[index]['nama_obat']);
                      }, icon: Icon(Icons.delete)),
                    );
                  
                },),
              ),
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>form_entryobat(),));
            }, child: Text('INPUT', style: TextStyle(fontSize: 20),))
          ],
        ),

      ),
    );
  }
}