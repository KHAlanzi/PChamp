import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/home_screen1.dart';
import 'package:first_app/login_screen.dart';
import 'package:first_app/letters.dart';
import 'package:first_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing Controller
  final firstNameEditingController = new TextEditingController();
  final ageEditingController = new TextEditingController(); //addition
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name filde
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      // ignore: missing_return
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if (value.isEmpty) {
          return ('الرجاء ادخال الاسم ');
        }
        if (!regExp.hasMatch(value)) {
          return (" الاسم غير صحيح(ثلاث حروف على الاقل)");
        }
      },
      onSaved: (value) {
        firstNameEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "الاسم",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );

    //age filde
    final ageField = TextFormField(
      autofocus: false,
      controller: ageEditingController,
      //keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return "الرجاء ادخال العمر";
        }
        final toInt = int.tryParse(value);
        if (toInt < 2 || toInt > 8) {
          return "العمر غير صحيح";
        }
        return null;
      },
      onSaved: (value) {
        ageEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.date_range_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "العمر",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );

    //email filde
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return ("الرجاء ادخال البريد الالكتروني ");
        }
        //expression for email valid
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("البريد الالكتروني غير صحيح");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "البريد الالكتروني",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      // ignore: missing_return
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if (value.isEmpty) {
          return ('الرجاء ادخال كلمة المرور');
        }
        if (!regExp.hasMatch(value)) {
          return ("كلمة المرور غير صحيحة(سته حروف او ارقام على الاقل)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "كلمة المرور",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );

    //conf password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return "الرجاء تأكيد كلمة المرور";
        }
        if (confirmPasswordEditingController.text.length > 6 &&
            passwordEditingController.text != value) {
          return "كلمة المرور غير متطابقة";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "تأكيد كلمة المرور",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );

//create account button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(40),
      color: Colors.blue,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (signUp(emailEditingController.text,
                    passwordEditingController.text) ==
                true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Letters_screen()));
            } else {}
          },
          child: Text(
            "انشاء حساب جديد ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    //login button
    final loginUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(40),
      color: Colors.blue,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen())); //call the other page
          },
          child: Text(
            "تسجيل الدخول",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assest/p4.jpg"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(30.0), //العرض
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 185, //image
                      child: Image.asset(
                        "assest/PCH.jpg",
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: 10),
                  firstNameField,
                  SizedBox(height: 10),
                  ageField,
                  SizedBox(height: 10),
                  emailField,
                  SizedBox(height: 10),
                  passwordField,
                  SizedBox(height: 10),
                  confirmPasswordField,
                  SizedBox(height: 10),
                  signUpButton,
                  SizedBox(height: 10),
                  loginUpButton,
                  SizedBox(height: 10),
                ],
              )),
        ),
      ),
    );
  }

  Future<bool> signUp(String email, String password) async {
    if (_formKey.currentState.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
      return true;
    } else {
      return false;
    }
  }

  postDetailsToFirestore() async {
    //call firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    //call user moudel
    UserModel userModel = UserModel();

//write values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.firstname = firstNameEditingController.text;
    userModel.age = ageEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "تم انشاء الحساب بنجاح");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen1()),
        (route) => false);

    //sending values
  }
}
