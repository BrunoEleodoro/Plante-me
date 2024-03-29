import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:plante_me/pages/error_page.dart';
import 'package:plante_me/pages/success_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:async/async.dart' as async_lib;

class RegisterPlant extends StatefulWidget {
  @override
  _RegisterPlantState createState() => _RegisterPlantState();
}

class _RegisterPlantState extends State<RegisterPlant> {
  var selectedValue = "Semente";
  File _image;
  String base64 = "";
  var isLoading = false;
  var id_planta;
  var img_name;

  SharedPreferences prefs;
  TextEditingController controller_apelido = new TextEditingController();
  TextEditingController controller_codigo = new TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    List<int> imageBytes = image.readAsBytesSync();

    setState(() {
      _image = image;
      base64 = base64Encode(imageBytes);
    });
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.image) {
          _image = response.file;
          setState(() {});
        }
      });
    } else {}
  }

  void registerPlant() async {
    print('registerPlant');
    setState(() {
      isLoading = true;
    });

    var stream = new http.ByteStream(
        async_lib.DelegatingStream.typed(_image.openRead()));
    var length = await _image.length();

    var uri = Uri.parse(
        'https://plantemenode.herokuapp.com/plantas/usuario/adicionar/img');

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: path.basename(_image.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.addAll({'Authorization': prefs.getString("token")});
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var data = jsonDecode(value);
      print(data['img']);

      reallySave(data['img']);
    });

//
  }

  void reallySave(img) async {
    var url = 'https://plantemenode.herokuapp.com/plantas/usuario/adicionar';
    try {
      var response = await http.post(url, body: {
        'apelido': controller_apelido.text,
        'estado': selectedValue,
        'codigo': controller_codigo.text,
        'tipo': id_planta.toString(),
        'img': img
      }, headers: {
        'Authorization': prefs.getString("token")
      });

      print(response.body);

      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessPage(
              message: 'Salvo com sucesso!',
              route: 'home',
            ),
          ));
    } catch (ex) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(
              message: 'Erro: ' + ex,
              route: 'myself',
            ),
          ));
    }
  }

  void validarCodigo() async {
    setState(() {
      isLoading = true;
    });

    var url = 'https://plantemenode.herokuapp.com/codigo';
    var response = await http.post(url,
        body: {'codigo': controller_codigo.text},
        headers: {'Authorization': prefs.getString("token")});
    print(response.body);
    if (response.statusCode == 500) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(
              message: 'Código inexistente!',
              route: 'myself',
            ),
          ));
    } else {
      var json = jsonDecode(response.body);
      print(json);
      setState(() {
        id_planta = json['id_planta'];
        isLoading = false;
      });
      registerPlant();
    }
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      retrieveLostData();
    }
    loadData();
    super.initState();
  }

  void loadData() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFfbfbfb),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,
                                  color: Color(0XFF11c180)),
                            ),
                            Text(
                              'Adicionar planta',
                              style: TextStyle(color: Color(0XFF11c180)),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Text(''),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            (this.isLoading)
                                ? LinearProgressIndicator()
                                : Text(''),
                            (_image == null)
                                ? DottedBorder(
                                    padding: EdgeInsets.all(4),
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(100),
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          this.getImage();
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Minha\nprimeira foto',
                                              style: TextStyle(
                                                  color: Color(0XFF11c180)),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Opacity(
                                              opacity: 0.2,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Color(0XFF11c180),
                                                size: 30,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                : GestureDetector(
                                    onTap: () {
                                      this.getImage();
                                    },
                                    child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                              image: FileImage(_image),
                                              fit: BoxFit.cover),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                        ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                          controller: controller_apelido,
                          obscureText: false,
                          decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(
                                    color: Color(0XFFD9D8D7), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(
                                    color: Color(0XFFD9D8D7), width: 1.0),
                              ),
                              labelText: 'Apelido da planta',
//              labelStyle: TextStyle(color: Color(0XFFD9D8D7)),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ))),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          border: Border.all(
                              color: Color(0XFFD9D8D7),
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        child: DropdownButton<String>(
                          hint: new Text("Estagio"),
                          value: this.selectedValue,
                          onChanged: (String newValue) {
                            setState(() {
                              selectedValue = newValue;
                            });
                          },
                          items: [
                            new DropdownMenuItem<String>(
                              value: 'Semente',
                              child: new Text(
                                'Semente',
                                style: new TextStyle(color: Colors.black),
                              ),
                            ),
                            new DropdownMenuItem<String>(
                              value: 'Em germinação',
                              child: new Text(
                                'Em germinação',
                                style: new TextStyle(color: Colors.black),
                              ),
                            ),
                            new DropdownMenuItem<String>(
                              value: 'Muda',
                              child: new Text(
                                'Muda',
                                style: new TextStyle(color: Colors.black),
                              ),
                            ),
                            new DropdownMenuItem<String>(
                              value: 'Adulta',
                              child: new Text(
                                'Adulta',
                                style: new TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Center(
                              child: Text(
                        'Codigo da planta',
                        textAlign: TextAlign.center,
                      ))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0XFF707070)),
                        child: TextField(
                          controller: controller_codigo,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                          obscureText: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.maxFinite,
                        child: MaterialButton(
                          color: Color(0XFF11c180),
                          height: 50,
                          onPressed: () {
                            this.validarCodigo();
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => SuccessPage(
//                                    message: 'Filomena adicionada!',
//                                    route: 'home',
//                                  ),
//                                ));
                          },
                          child: Text(
                            'CONTINUAR',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ]))));
  }
}
