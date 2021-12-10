import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Chat/constants.dart';
import 'package:meras/screen/Chat/screens/Backg.dart';
import 'package:meras/screen/Chat/screens/chat.dart';
import 'package:meras/screen/home/CnavDrawer.dart';



class Cchat extends StatefulWidget {
  @override
  _CchatState createState() => _CchatState();
}

class _CchatState extends State<Cchat> {
  //final ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
 

  Widget build(BuildContext context) {
   FirebaseAuth auth = FirebaseAuth.instance;
 final User? user = auth.currentUser;
    final Muid = user!.uid;
    return Scaffold(
      drawer: CNavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'المحادثات',
         // textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Backg(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance
                          .collection("messages")
                           .orderBy('Time', descending: true)
                          .where('peers', arrayContains: Muid)
                          .snapshots(),
                    //FirebaseFirestore.instance.collection('Coach').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Loading();
                  return ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(), //<--here
                    //controller: _scrollController,

                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, (snapshot.data!).docs[index]),
                  );
                }),
          ),
        ),
      ),
    );
  }



 Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
   String fullname=document['Tname'];
   String shortM='';
   String pic="";
   String from="";
   int spl= fullname.indexOf(' ');
   String Fname= fullname.substring(0, spl); 

if(document['lastMessage'].toString().contains("https://firebasestorage")){
   pic = "صورة" ;
} 
else if(document['lastMessage'].toString().length > 20){
     String lla= document['lastMessage'];
   shortM =  "..."+ lla.substring(0,18) ;
}
else shortM= document['lastMessage'];

if (shortM.contains("\n")){
  shortM= shortM.substring(0,shortM.indexOf("\n"));
}

if (document['lastFrom']==document['Cid'] )
   from='أنت: ';
else 
   from=Fname+": ";
   
   

   late String tname='';
   late String pn='';
   FirebaseFirestore.instance
      .collection('trainees')
      .doc(document['Tid'])
      .get()
      .then((ds) {
    tname = ds['Fname'] + ' ' + ds['Lname'];
    pn=ds['Phone Number'];
  }).catchError((e) {
    print(e);
  });

  //print("here is the short $shortM");
    return SingleChildScrollView(    
          child: Container(
              height: 104,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Material(
              child: InkWell(
                  onTap: (){  
                    Navigator.of(context).push( MaterialPageRoute(
              builder: (context) => 
              Chat(
              currentUserId: document['Cid'], 
              peerAvatar: "https://i.postimg.cc/PqFhPxLy/TF.png",
              peerId:document['Tid'], 
              peerName: document['Tname'] ,
              Cname:document['Cname'] ,
              Tname: tname,
              Tid: document['Tid'],
              Cid: document['Cid'],  
              phone: pn,
              ),
              

              
              ),);
                  }
                  ,splashColor: Colors.purple[200],
                  child: Card(
                child: ListTile(
                  leading:  Text( DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document['lastTime'].toString())
                              )),
                              style: TextStyle(height: 5, fontSize: 11.7,color: greyColor),),
                  title: Text(
                    document['Tname'],
                    style: TextStyle(height: 2, fontSize: 15.9),
                    textAlign: TextAlign.right,
                  ),
                  subtitle:  
                  (pic == "صورة")? 
                  RichText(
                    textAlign: TextAlign.right,
                    text: 
                  TextSpan(
                    text: 
                    from,   
                    style: TextStyle(height: 2, fontSize: 15,color: Colors.green[700],),//fontWeight: FontWeight.bold),
                   
                  children: <TextSpan>[
             TextSpan(
               text: "صورة",
                style: TextStyle(height: 2, fontSize: 15,color: Colors.blue,fontWeight: FontWeight.normal),
                ),
          ]
     ),
)
                 :  RichText(
                    textAlign: TextAlign.right,
                    text: 
                  TextSpan(
                    text: 
                    from,   
                    style: TextStyle(height: 2, fontSize: 15,color: Colors.green[700],),//fontWeight: FontWeight.bold),
                   
                  children: <TextSpan>[
             TextSpan(
               text: shortM,
                style: TextStyle(height: 2, fontSize: 15,color: Colors.grey,fontWeight: FontWeight.normal),
                ),
          ]
     ),
),
                  trailing: 
                       Image.asset("assets/images/TF.png"),
              ),
            )
          
    ))));
  }
}