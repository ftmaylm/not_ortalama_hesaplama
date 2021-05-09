import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarf = 4;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama =0;
  static int sayac=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context,orientation){
        if(orientation ==  Orientation.portrait){
          return uygulamaGovdesi();
        }else{
          return uygulamaGovdesiLandscope();
        }

      },),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            color: Colors.purple.shade50,
            child: Form(
              key: formKey,
              child:  Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Ders Adı",
                        hintText: "Ders Adı Giriniz",
                        labelStyle:
                            TextStyle(fontSize: 22, color: Colors.indigo),
                        hintStyle: TextStyle(fontSize: 18),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all((Radius.circular(10))),
                        ),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.length > 0) {
                          return null;
                        } else {
                          return "Ders Alanı Boş Bırakılamaz!!";
                        }
                      },
                      onSaved: (kaydedilecekDeger) {
                        dersAdi = kaydedilecekDeger;
                        setState(() {
                          tumDersler.add(Ders(dersAdi, dersHarf, dersKredi,rastgeleRenkOlustur()));
                          ortalama=0;
                          ortalamaHesapla();
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKredileriItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.all((Radius.circular(10))),
                        ),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfleriItems(),
                            value: dersHarf,
                            onChanged: (secilenHarf) {
                              setState(() {
                                dersHarf = secilenHarf;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.all((Radius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.deepPurple,
            height: 50,
            child: Center(child: Text(tumDersler.length ==0 ? "Lütfen ders ekleyin" : "Ortalama: ${ortalama.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontSize: 30),)),
          ),
          Expanded(
            child: Container(
                color: Colors.white54,
                child: ListView.builder(
                  itemBuilder: _listeElemanlariniOlustur,
                  itemCount: tumDersler.length,
                )),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i < 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text("$i Kredi", style: TextStyle(fontSize: 30)),
      ));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfleriItems() {
    List<DropdownMenuItem<double>> harfler = [];

    harfler.add(DropdownMenuItem(
      child: Text(
        " AA ",
        style: TextStyle(fontSize: 30),
      ),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BA ",
        style: TextStyle(fontSize: 30),
      ),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " BB ",
        style: TextStyle(fontSize: 30),
      ),
      value: 3.0,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CB ",
        style: TextStyle(fontSize: 30),
      ),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " CC ",
        style: TextStyle(fontSize: 30),
      ),
      value: 2.0,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DC ",
        style: TextStyle(fontSize: 30),
      ),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " DD ",
        style: TextStyle(fontSize: 30),
      ),
      value: 1.0,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(
        " FF ",
        style: TextStyle(fontSize: 30),
      ),
      value: 0,
    ));

    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {

    sayac++;
    Color renk = rastgeleRenkOlustur();
    
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: tumDersler[index].renk, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(Icons.auto_awesome_mosaic,size: 36, color: tumDersler[index].renk),
          title: Text(tumDersler[index].ad),
          subtitle: Text(tumDersler[index].kredi.toString() +
              "kredi   " +
              tumDersler[index].harf.toString()),
          trailing: Icon(Icons.arrow_forward_ios, size: 36, color: tumDersler[index].renk,),
        ),
      ),
    );
  }

  void ortalamaHesapla() {

    double toplamNot = 0;
    double toplamKredi = 0;

    for(var oankiders in tumDersler){

      var kredi = oankiders.kredi;
      var harf = oankiders.harf;
      toplamNot = toplamNot+ (harf*kredi);
      toplamKredi += kredi;
    }

    ortalama = toplamNot / toplamKredi;
  }

  Color rastgeleRenkOlustur() {

    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
  }

  Widget uygulamaGovdesiLandscope() {

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              color: Colors.purple.shade50,
              child: Form(
                key: formKey,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ders Adı",
                          hintText: "Ders Adı Giriniz",
                          labelStyle:
                          TextStyle(fontSize: 22, color: Colors.indigo),
                          hintStyle: TextStyle(fontSize: 18),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all((Radius.circular(10))),
                          ),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger.length > 0) {
                            return null;
                          } else {
                            return "Ders Alanı Boş Bırakılamaz!!";
                          }
                        },
                        onSaved: (kaydedilecekDeger) {
                          dersAdi = kaydedilecekDeger;
                          setState(() {
                            tumDersler.add(Ders(dersAdi, dersHarf, dersKredi,rastgeleRenkOlustur()));
                            ortalama=0;
                            ortalamaHesapla();
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              items: dersKredileriItems(),
                              value: dersKredi,
                              onChanged: (secilenKredi) {
                                setState(() {
                                  dersKredi = secilenKredi;
                                });
                              },
                            ),
                          ),
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.all((Radius.circular(10))),
                          ),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<double>(
                              items: dersHarfleriItems(),
                              value: dersHarf,
                              onChanged: (secilenHarf) {
                                setState(() {
                                  dersHarf = secilenHarf;
                                });
                              },
                            ),
                          ),
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.deepPurple, width: 2),
                            borderRadius: BorderRadius.all((Radius.circular(10))),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.deepPurple,
                      height: 100,
                      child: Center(child: Text(tumDersler.length ==0 ? "Lütfen ders ekleyin" : "Ortalama: ${ortalama.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontSize: 30),)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
                color: Colors.white54,
                child: ListView.builder(
                  itemBuilder: _listeElemanlariniOlustur,
                  itemCount: tumDersler.length,
                )),

          ),
        ],
      ),
    );
  }
}

class Ders {

  String ad;
  double harf;
  int kredi;
  Color renk;

  Ders(this.ad, this.harf, this.kredi,this.renk);
}
