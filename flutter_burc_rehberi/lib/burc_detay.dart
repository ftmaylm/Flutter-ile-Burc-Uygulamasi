import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/burc_liste.dart';
import 'models/burc.dart';
import 'package:palette_generator/palette_generator.dart';

class BurcDetay extends StatefulWidget {
  int gelenIndex;

  BurcDetay(this.gelenIndex);

  @override
  _BurcDetayState createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Burc secilenBurc;
  Color baskinRenk;
  Color acikRenk;
  Color yaziRengi;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    super.initState();
    secilenBurc = BurcListesi.tumBurclar[widget.gelenIndex];
    BaskinRengiBul();
    AcikRengiBul();
    YaziRengiBul();
  }

  void BaskinRengiBul() {
    Future<PaletteGenerator> fPaletteGenerator =
        PaletteGenerator.fromImageProvider(
            AssetImage("images/" + secilenBurc.burcBuyukResim));
    fPaletteGenerator.then((value) {
      paletteGenerator = value;
      setState(() {
        baskinRenk = paletteGenerator.dominantColor.color;
      });
    });
  }

  void AcikRengiBul() {
    Future<PaletteGenerator> fPaletteGenerator =
        PaletteGenerator.fromImageProvider(
            AssetImage("images/" + secilenBurc.burcBuyukResim));
    fPaletteGenerator.then((value) {
      paletteGenerator = value;
      //debugPrint("seçilen renk: " +paletteGenerator.lightVibrantColor.color.toString() );
      setState(() {
        acikRenk = paletteGenerator.lightMutedColor.color;
      });
    });
  }

  void YaziRengiBul() {
    Future<PaletteGenerator> fPaletteGenerator =
        PaletteGenerator.fromImageProvider(
            AssetImage("images/" + secilenBurc.burcBuyukResim));
    fPaletteGenerator.then((value) {
      paletteGenerator = value;
      setState(() {
        yaziRengi = paletteGenerator.lightVibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            primary: true,
            backgroundColor: baskinRenk != null ? baskinRenk : Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "images/" + secilenBurc.burcBuyukResim,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
              title: Text(
                secilenBurc.burcAdi + " Burcu ve Özellikleri",
                style: TextStyle(
                    backgroundColor:  baskinRenk != null ? baskinRenk : Colors.pink,
                    fontSize: 18,
                    color: yaziRengi != baskinRenk ? yaziRengi : Colors.white),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: acikRenk != null ? acikRenk : Colors.pink.shade50,
                //borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    secilenBurc.burcDetay,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
