import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(form_entryobat());
}

class form_entryobat extends StatelessWidget{
  TextEditingController xnama = TextEditingController();
  TextEditingController xsatuan = TextEditingController();
  TextEditingController xkode = TextEditingController();
  TextEditingController xjumlah = TextEditingController();
  TextEditingController xharga = TextEditingController();

  Future<void> simpan_obat() async {
    String url = "http://192.168.1.10/simpan_obat.php";
    try {
      final respon=await http.post(Uri.parse(url),body: {
        'xnama':xnama.text, 
        'xsatuan':xsatuan.text, 
        'xkode':xkode.text,
        'xjumlah':xjumlah.text,
        'xharga':xharga.text
        });
        if (respon.statusCode ==  200)
        {
            print('Simpan Berhasil..!');
        }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Entry Data Obat'),
          ),
          body: Column(
            children: [
              Container(margin: EdgeInsets.all(20),
                child: TextField(
                  controller: xnama,
                   decoration: InputDecoration(
                    labelText: 'Nama Obat',
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                ),
              ),
              Container(margin: EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  controller: xsatuan,
                   decoration: InputDecoration(
                    labelText: 'Nama Satuan Obat',
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10, left: 20,right: 20),
                child: TextField(
                  controller: xkode,
                   decoration: InputDecoration(
                    labelText: 'Nama Kode Obat',
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10, left: 20,right: 20),
                child: TextField(
                  controller: xjumlah,
                   decoration: InputDecoration(
                    labelText: 'Jumlah Obat',
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10, left: 20,right: 20),
                child: TextField(
                  controller: xharga,
                   decoration: InputDecoration(
                    labelText: 'Harga Obat',
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                ),
              ),
              Container(margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: (){
                    simpan_obat();
                  }, child: Text('SIMPAN'))
              ),
            ],
          ),
        ),
      );
  }
}