import 'package:config_firebase/components/prueba_button.dart';
import 'package:config_firebase/components/prueba_text_field.dart';
import 'package:config_firebase/firebase/logs.dart';
import 'package:config_firebase/firebase/references.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'model/prueba_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Prueba conexión firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String idMostrar = "";
  String datoMostrar = "Aquí se mostrará el dato que cargamos";
  String idSubir = "";
  String datoSubir = "";
  String idActualizar = "";
  String datoActualizar = "";
  List<Prueba> listaPrueba = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Datos que vamos a subir a la base de datos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PruebaTextField(
                      title: "Dato a subir",
                      onChanged: (text) {
                        setState(() {
                          datoSubir = text;
                        });
                      },
                    ),
                  ),
                  PruebaTextField(
                    title: "Id dato a subir",
                    onChanged: (text) {
                      setState(() {
                        idSubir = text;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PruebaButton(
                        onPressed: () {
                          _addProduct();
                        },
                        title: "subir"),
                  ),
                  Text(
                    'Datos que vamos a modificar en la base de datos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PruebaTextField(
                      title: "Dato a actualizar",
                      onChanged: (text) {
                        setState(() {
                          datoActualizar = text;
                        });
                      },
                    ),
                  ),
                  PruebaTextField(
                    title: "Id dato a actualizar",
                    onChanged: (text) {
                      setState(() {
                        idActualizar = text;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PruebaButton(
                        onPressed: () {
                          _getPrueba(true);
                        },
                        title: "Actualizar"),
                  ),
                  Text(
                    'Datos que vamos a descargar de la base de datos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PruebaButton(
                        onPressed: () {
                          _getPrueba(false);
                          setState(() {
                            datoMostrar = listaPrueba[0].datoPrueba;
                          });
                        },
                        title: "Descargar"),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue, width: 3)),
                    child: Center(
                      child: Text(
                        datoMostrar,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addProduct() {
    Map<String, dynamic> liveDoc = {
      "id": idSubir,
      "Dato de prueba": datoSubir,
    };
    LogMessage.post("PRUEBA");
    References.prueba.add(liveDoc).then((r) {
      LogMessage.postSuccess("PRUEBA");
      Alert(
          context: context,
          title: "Add",
          desc: "Se han cargado los datos con éxito.",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]).show();
    }).catchError((e) {
      LogMessage.postError("PRUEBA", e);
    });
  }

  void _getPrueba(bool update) {
    LogMessage.get("PRUEBA");
    References.prueba
        .where("id", isEqualTo: idActualizar)
        .snapshots()
        .listen((querySnapshot) {
      listaPrueba.clear();
      LogMessage.getSuccess("PRUEBA");
      if (!update) {
        Alert(
            context: context,
            title: "Get",
            desc: "Se han traido los datos con éxito.",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ]).show();
      }

      if (querySnapshot.documents.isNotEmpty) {
        // Sí hay documentos
        querySnapshot.documents.forEach((pruebaDoc) {
          setState(() {
            listaPrueba.add(
              Prueba(
                  id: pruebaDoc.documentID,
                  datoPrueba: pruebaDoc.data["Dato de prueba"]),
            );
          });
        });
        if (update) {
          _updatePrueba();
        }
      }
    }).onError((e) {
      LogMessage.getError("PRUEBA", e);
    });
  }

  void _updatePrueba() {
    Map<String, dynamic> liveMap = {
      "id": idActualizar,
      "Dato de prueba": datoActualizar,
    };
    print("⏳ ACTUALIZARÉ PRUEBA");
    References.prueba
        .document(listaPrueba[0].id)
        .updateData(liveMap)
        .then((r) async {
      print("✔ PRUEBA ACTUALIZADA");
      Alert(
          context: context,
          title: "Update",
          desc: "Se han actualizado los datos con éxito.",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]).show();
    }).catchError((e) {
      print("💩️ ERROR AL ACTUALIZAR PRUEBA: $e");
    });
  }
}
