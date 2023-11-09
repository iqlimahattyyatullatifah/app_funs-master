import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:funs_app/pages/home.dart';
import 'package:funs_app/pages/testhome.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  bool _isvisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/img/background.png',
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                duration: Duration(seconds: 4),
                tween: Tween<double>(begin: 0.0, end: 0.99),
                curve: Curves.bounceIn,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Image.asset(
                    'assets/img/logo-horizontal.png',
                    width: 300,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: TweenAnimationBuilder(
                  duration: Duration(seconds: 2),
                  tween: Tween<double>(begin: 20, end: 300),
                  curve: Curves.easeIn,
                  builder: (context, value, child) => Container(
                    height: 50,
                    width: value,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(2, 2),
                              color: Colors.blue.withOpacity(0.3))
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade300),
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: emailC,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TweenAnimationBuilder(
                duration: Duration(seconds: 2),
                tween: Tween<double>(begin: 20, end: 300),
                curve: Curves.easeIn,
                builder: (context, value, child) => Container(
                  height: 50,
                  width: value,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: Offset(2, 2),
                            color: Colors.blue.withOpacity(0.3))
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade300),
                  child: TextField(
                    controller: passwordC,
                    obscureText: _isvisible,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isvisible = !_isvisible;
                              });
                            },
                            icon: _isvisible
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.white,
                                  )),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TweenAnimationBuilder(
                duration: Duration(seconds: 3),
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.bounceIn,
                builder: (context, value, child) => SizedBox(
                  width: 130,
                  child: Opacity(
                    opacity: value,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailC.text,
                                    password: passwordC.text);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                                (route) => false);
                          } on FirebaseAuthException catch (e) {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.success,
                              title: 'Ada yang salah, silahkan login kembali',
                              btnOkOnPress: () {},
                            ).show();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: Colors.orange.shade400,
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
