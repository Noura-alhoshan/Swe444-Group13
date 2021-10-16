import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/services/BaseAlertDialog.dart';
import 'package:meras/screen/Admin/services/google_auth_api.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Admin/widget/FullScreen.dart';
import 'package:meras/screen/Admin/widget/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
//final FirebaseFirestore fuser = FirebaseFirestore.instance;

class ViewLessonRequest extends StatefulWidget {
  final String id;
  ViewLessonRequest(this.id);

  @override
  _ADcoachProfileScreenState createState() => _ADcoachProfileScreenState();
}

Color red = Color(0xFFFFCDD2);
Color green = Color(0xFFC8E6C9);

class _ADcoachProfileScreenState extends State<ViewLessonRequest> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '                          معلومات الدرس',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Requests')
              .where(FieldPath.documentId, isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading(); //it was text 7.....
            return ListView.builder(
              controller: _scrollController,

              //  physics: const NeverScrollableScrollPhysics(), //<--here
              itemCount: 1,

              itemBuilder: (context, index) =>
                  _build(context, (snapshot.data!).docs[0]),
            );
          }),
    );
  }

Widget _build(BuildContext context, DocumentSnapshot document) {
    final String ph= document['Phone Number'];
    // Image im = new Image.network(
    //   document['URL'],
    //   height: 230.0,
    //   width: 250.0,
    // );
    return BackgroundA(
      child:
          Align( 
      alignment: const Alignment(-0.1, -0.5),
      child: Container(
      width: 300,
      height: 600,
      
      padding: EdgeInsets.only(bottom: 10, top: 0),
      decoration: 
     BoxDecoration(
     
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 0, right: 0, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text("معلومات المتدرب",
            //     style: TextStyle(
            //         fontSize: 23,
            //         //fontFamily: "Poppins-Bold",
            //         letterSpacing: .6)),
            // SizedBox(
            //   height:30,
            // ),
           
      Container(
        height: 508,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.deepPurple.shade50,
                Colors.white10,
              ],
            )),
            //  height: 1200,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 00),
            child: Column(children: <Widget>[
              // Icon(ic)
               Divider(color: Colors.deepPurple[900]),
              Text("معلومات المتدرب",
                style: TextStyle(
                    fontSize: 23,
                    //fontFamily: "Poppins-Bold",
                    letterSpacing: .6,
                    fontWeight: FontWeight.bold
                    )),
              Text(
                document['Fname'] + ' ' + document['Lname'] + '  ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    // color: kPrimaryColor,
                    ),
              ),
              // Text(
              //   document['Email'],
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              // ),
             
              TextButton(
                 
                  child: Text(document['Phone Number'],
                  style: TextStyle(fontSize: 16, color: Colors.grey,decoration: TextDecoration.underline,)),
                  onPressed: (){ launch("tel://$ph");}),
             
              Container(
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 0),
                      children: [
                        TableRow(children: [
                          Column(children: [Text('')]),
                          Column(children: [
                            Text('')
                          ]), //Column(children:[Text('')]),
                        ]),
                        TableRow(children: [
                          //Column(children:[Text('')]),
                         
                            Container(
                           padding: EdgeInsets.all(2.0),
                           child: Text(
                              document['Gender'],
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.right,
                            ),),
                          
                          Container(
                           padding: EdgeInsets.all(2.0),
                           child:
                            Text(
                              'الجنس',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.end,
                            )
                          ),
                        ]),
                        TableRow(children: [
                          Column(children: [Text('')]),
                          Column(children: [
                            Text('')
                          ]), //Column(children:[Text('')]),
                        ]),
                        TableRow(children: [
                          //Column(children:[Text('')]),
                           Container(
                           padding: EdgeInsets.all(2.0),
                           child:
                            Text(document['Age'].toString(),
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey,), textAlign: TextAlign.right,)
                          ),
                           Container(
                           padding: EdgeInsets.all(2.0),
                           child:
                            Text('العمر', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.right,)
                           ),
                        ]),
                        TableRow(children: [
                          Column(children: [Text('')]),
                          Column(children: [
                            Text('')
                          ]), //Column(children:[Text('')]),
                        ]),
                        TableRow(children: [
                          // Column(children:[Text('')]),
                          Container(
                           padding: EdgeInsets.all(0),
                           child:
                            Text(document['Neighborhood'],
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),textAlign: TextAlign.right,)
                          ),
                           Container(
                           padding: EdgeInsets.all(0),
                           child:
                            Text('المنطقة السكنية',
                                style: TextStyle(fontSize: 20.0),textAlign: TextAlign.right,)
                          ),
                        ]),
                      ],
                    ),
                  ),

                  
                   
                  SizedBox(
                    height: 24,
                  ),
                  Row(children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 5)),
                    Center(child: Accept(document)),
                    SizedBox(width: 24),
                    Center(child: Reject(document)),
                  ]),
                ]),
              ),
            ]),
          ),
        ),
      ),
          ]),
                
          
        ),
      ),
    ),
    )
    
    ;
  }



   Widget Reject(DocumentSnapshot document) => ButtonWidget(
        colorr: red,
        text: 'رفض',
        onClicked: () async {
          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من رفض الدرس",
              yesOnPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Requests')
                    .doc(widget.id)
                    .update({'Status': 'D'});

                // deleteUser();
                nav1();
                
              },
              noOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              yes: "نعم",
              no: "لا");
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
        },
      );




  Widget Accept(DocumentSnapshot document) => ButtonWidget(
        colorr: green,
        text: 'قبول',
        onClicked: () async {
          var baseDialog = BaseAlertDialog(
              title: "",
              content: "هل أنت متأكد من قبول الدرس؟",
              yesOnPressed: () async {
                
                await FirebaseFirestore.instance
                    .collection('Requests')
                    .doc(widget.id)
                    .update({'Status': 'A'});

                nav1();
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              noOnPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              yes: "نعم",
              no: "لا");
          showDialog(
              context: context, builder: (BuildContext context) => baseDialog);
        },
      );



void nav1() async {
    // Navigator.pushNamed(context, '/ADcategory'); //nn
    Navigator.of(context).pop();
    // Navigator.of(context, rootNavigator: true)
    //     .pop('dialog'); ////////////////////////// to be ubdated
  }


















}