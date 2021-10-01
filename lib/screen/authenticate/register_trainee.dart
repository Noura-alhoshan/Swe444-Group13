import 'package:meras/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class RegisterAsTrainee extends StatefulWidget {

  final Function toggleView;
  RegisterAsTrainee({ required this.toggleView });

  @override
  _RegisterAsTraineeState createState() => _RegisterAsTraineeState();
}

enum SingingCharacter { lafayette, jefferson }
class _RegisterAsTraineeState extends State<RegisterAsTrainee> {

  SingingCharacter? _character = SingingCharacter.lafayette;


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  String dropdownValue = 'الرمال وماحولها';
  var items = ['الرمال وماحولها','اليرموك وماحولها','الملقا وماحوله','العارض وماحوله',
    'الملز وماحولها','ظهرة لبن وماحولها','السويدي وماحوله','العزيزية وماحولها',
    'السلي وماحولها','طويق وماحولها','الدرعية وماحولها','الملك فهد وماحوله', 'عرقة وماحولها',
    'العقيق وماحولها','العليا وماحولها'];

  // text field state
  String Fname = '';
  String Lname = '';
  String email = '';
  String password = '';
  //String age = '';
  String phoneNumber = '';
  String neighborhood = '';
  String gender = '';

  int _age = 0;
  String _message = '';

  void ageOnSubmitted(String value) {
    try {
      _age = int.parse(value);
    } on FormatException catch(ex) {
      setState(() {
        _message = "من فضلك أدخل عمرك حيث لا يقل عن ١٧ عام";
      });
    }
  }

  void enterMeras() {
    setState(() {
      if (_age > 17) {
        _message = "مرحبًا بك!";
      }
      else {
        _message = "تأكد من إدخال جميع المعلومات بشكل صحيح";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        elevation: 0.0,
        title: Text('مِرَاس حيث سهولة التعلم'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('تسجيل الدخول'),

            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),

                      hintText: "الأسم الأول"),
                  validator: (val) => val!.isEmpty ? 'الرجاء إدخال الأسم الأول' : null,
                  onChanged: (val) {
                    setState(() => Fname = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),

                      hintText: "الأسم الأخير"),
                  validator: (val) => val!.isEmpty ? 'الرجاء إدخال الأسم الأخير' : null,
                  onChanged: (val) {
                    setState(() => Lname = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "البريد الإلكتروني"),
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال البريد الإلكتروني' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),

                      hintText: "كلمة المرور"
                  ),
                  obscureText: true,
                  validator: (val) => val!.length < 6 ? '   الرجاء إدخال كلمة المرور بشكل صحيح' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "العمر"),
                  onChanged: ageOnSubmitted,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2 ,color: Colors.deepPurple),
                      ),
                      hintText: "رقم الجوال"),
                  validator: (val) => val!.isEmpty? 'الرجاء إدخال رقم الجوال' : null,//added ! to val
                  onChanged: (val) {
                    setState(() => phoneNumber = val);
                  },
                ),
                SizedBox(height: 20.0),
                Text(':اختر منطقتك السكنيةأو المنطقة التي تريد التدرب فيها', textAlign: TextAlign.right,),
                Column(
                  children: <Widget>[
                    DropdownButton(
                        items: items.map((itemsName) {
                          return DropdownMenuItem(
                              value: itemsName,
                              child: Text(itemsName)
                          );
                        }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          neighborhood = newValue;
                        });
                      },
                      value: dropdownValue,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconEnabledColor: Colors.deepPurple,
                    )
                  ],
                ),
                Text(':الجنس                                                                             ',
                  textAlign: TextAlign.right,),
              Column(
              children: <Widget>[
                RadioListTile<SingingCharacter>(
                  //title: const Text('ذكر', textAlign: TextAlign.right,),
                  value: SingingCharacter.lafayette,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      gender = 'ذكر';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: Colors.deepPurple,
                ),
                RadioListTile<SingingCharacter>(
                  title: const Text('أنثى', textAlign: TextAlign.right,),
                  value: SingingCharacter.jefferson,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      gender = 'أنثى';
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                  activeColor: Colors.deepPurple,
                ),
              ],
             ),
                ElevatedButton(
                  //color: Colors.pink[400],
                    child: Text('إنشاء حساب متعلم'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple[50],
                      onPrimary: Colors.deepPurple[900],
                      //textStyle: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {//async
                      if(_formKey.currentState!.validate()){
                        dynamic result = _auth.registerAsTrainee(Fname, Lname, email, password, _age, phoneNumber, neighborhood, gender);//await
                        if(result == null) {
                          setState(() {
                            error = 'تأكد من إدخال المعلومات بشكل صحيح';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}