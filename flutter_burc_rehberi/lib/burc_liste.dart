import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/utils/strings.dart';
import 'models/burc.dart';

class BurcListesi extends StatelessWidget {
  static List<Burc> tumBurclar;

  @override
  Widget build(BuildContext context) {
    tumBurclar = veriKaynaginiHazirla();

    return Scaffold(
      appBar: AppBar(
        title: Text("Burç Rehberi", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo.shade50,),),
      ),
      body: listeyiHazirla(),
    );
  }

  List<Burc> veriKaynaginiHazirla() {
    List<Burc> burclar = [];

    for (int i = 0; i < 12; i++) {
      String kucukResim = Strings.BURC_ADLARI[i].toLowerCase() + "${i + 1}.png";
      String buyukResim =
          Strings.BURC_ADLARI[i].toLowerCase() + "_buyuk" + "${i + 1}.png";

      Burc eklenecekBurc = Burc(
          Strings.BURC_ADLARI[i],
          Strings.BURC_TARIHLERI[i],
          Strings.BURC_GENEL_OZELLIKLERI[i],
          kucukResim,
          buyukResim);
      burclar.add(eklenecekBurc);
    }
    return burclar;
  }

  Widget listeyiHazirla() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return tekSatirBurc(context, index);
      },
      itemCount: tumBurclar.length,
    );
  }

  Widget tekSatirBurc(BuildContext context, int index) {
    Burc oanListeyeEklenenBurc = tumBurclar[index];

    return Card(
      elevation: 6,
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, "/burcDetay/$index"),
          leading: Image.asset("images/" + oanListeyeEklenenBurc.burcKucukResim),
          title: Text(
            oanListeyeEklenenBurc.burcAdi,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.red.shade900),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              oanListeyeEklenenBurc.burcTarihi,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black54),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.red.shade700,
          ),
        ),
      ),
    );
  }
}
