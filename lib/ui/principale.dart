import 'package:flutter/material.dart';
import 'package:project_flutter/main.dart';
import 'package:camera/camera.dart';
import 'package:project_flutter/notification/notification_api.dart';
import 'package:project_flutter/ui/rechercher.dart';
import 'package:project_flutter/ui/accueil.dart';
import 'package:camera/camera.dart';
import '../notification/notification.dart';
import 'camera.dart';
import 'package:project_flutter/ui/create_reminder.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class principale extends StatelessWidget {


  
  var myMenuItems = <String>[
    'Paramètres',
    'Deconnexion',
  ];
  
  BuildContext? _context;

  Future<void> onSelect(item) async {
    switch (item) {
      case 'Paramètres':
        //createNotificationSTP();
        //DateTime.utc(2022,6,1,16);
        createReminderNotification(DateTime.now(),'a','b');
        break;
      case 'Deconnexion':
          Navigator.push(_context!,
            MaterialPageRoute(builder: (context) => accueil()));
        break;
    }
  }

  static String routeName = '/principale';

  principale({Key? key, required String title, required String content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
//===============================================================================================================
//===============================================================================================================
//=================================AppBar : 3 dots paramètres et Deconnexion=====================================
//===============================================================================================================
//===============================================================================================================

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 233, 233, 233),
          leading: const BackButton(color: Color.fromRGBO(75, 75, 75, 1)),
          centerTitle: true,
          title: const Text(
            'RemindMe',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromRGBO(75, 75, 75, 1)),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
                onSelected: onSelect,
                itemBuilder: (BuildContext context) {
                  return myMenuItems.map((String choice) {
                    return PopupMenuItem<String>(
                      child: Text(choice),
                      value: choice,
                    );
                  }).toList();
                })
          ],
        ),
      ),

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
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.125)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.42,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.42)),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(onPressed: () {
              Navigator.push( context, MaterialPageRoute(
                  builder: (context) => CameraScreen(cameras: cameras) // on passe la camera
                      ),
                );
            }, icon: const Icon(Icons.camera_alt_outlined, color: Color.fromARGB(255, 233, 233, 233))),
            label: "Photo",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TextFieldDateTimePicker()));
              },
              icon: const Icon(Icons.calendar_today),
            ),
            label: "Rappel",
          )
        ],
      ),
    );
  }
}
