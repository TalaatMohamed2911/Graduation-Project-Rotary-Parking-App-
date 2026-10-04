// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotary_parking/component/button.dart';
import 'package:rotary_parking/component/logo.dart';
import 'package:rotary_parking/component/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(27),
        children: [
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                ),
                const Logo(),
                const Text(
                  "SignUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 25,
                ),
                const Text(
                  "UserName",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 7,
                ),
                TextFormdesign(
                    enabled: true,
                    obscuretext: false,
                    labeltext: "Enter username",
                    mycontroller: username,
                    validator: (val) {
                      if (val == "") {
                        return "Can't Be Empty";
                      }
                      return null;
                    }),
                Container(
                  height: 7,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 7,
                ),
                TextFormdesign(
                    enabled: true,
                    obscuretext: false,
                    labeltext: "Enter your email",
                    mycontroller: email,
                    validator: (val) {
                      if (val == "") {
                        return "Can't Be Empty";
                      }
                      return null;
                    }),
                Container(
                  height: 7,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                TextFormdesign(
                    enabled: true,
                    obscuretext: true,
                    labeltext: "Enter your password",
                    mycontroller: pass,
                    validator: (val) {
                      if (val == "") {
                        return "Can't Be Empty";
                      }
                      return null;
                    }),
                Container(
                  height: 7,
                ),
                Container(
                  height: 25,
                ),
              ],
            ),
          ),
          Button(
            title: "Sign Up",
            onPressed: () async {
              if (formState.currentState!.validate()) {
                try {
                  // ignore: unused_local_variable
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: pass.text,
                  );
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  Navigator.of(context).pushReplacementNamed("login");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
                Navigator.of(context).pushReplacementNamed("login");
              } else {
                print("not valid");
              }
            },
          ),
          Container(
            height: 17,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
            child: const Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Have an account? "),
                    TextSpan(
                        text: "LogIn",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
