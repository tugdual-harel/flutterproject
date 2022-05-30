// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutterproject/RemindMe/Accueil.dart';
import 'package:flutterproject/RemindMe/Page_Principale/Principale.dart';
import 'package:flutterproject/RemindMe/Paramètres/Paramètres.dart';
import '../Data.dart';

class Parametres extends StatelessWidget {
  static String routeName = '/Parametres';
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

  Parametres({Key? key, required String title, String? content}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

//===============================================================================================================
//===============================================================================================================
//=================================AppBar : 3 dots paramètres et Deconnexion=====================================
//===============================================================================================================
//===============================================================================================================


      
//===============================================================================================================
//===============================================================================================================
//===============================================================================================================
//===============================================================================================================
//===============================================================================================================

      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          color: const Color.fromARGB(255, 233, 233, 233),

          child: Column(
            children: [

              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.125)),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)),
                    SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                        child: Column(
                          children:[
                            Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.42)),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

//===============================================================================================================
//===============================================================================================================
//=================================BottomBar : Rechercher et Créer ==============================================
//===============================================================================================================
//===============================================================================================================

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(75, 75, 75, 1),
        selectedItemColor: const Color.fromARGB(255, 233, 233, 233),
        unselectedItemColor: const Color.fromARGB(255, 233, 233, 233),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Color.fromARGB(255, 233, 233, 233)),
            label: 'Rechercher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Color.fromARGB(255, 233, 233, 233)),
            label: 'Créer', 
          ),
        ],

      ),

    );
  }
}