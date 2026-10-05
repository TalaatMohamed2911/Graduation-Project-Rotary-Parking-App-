import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotary_parking/components/button.dart';
import 'package:rotary_parking/components/logo.dart';
import 'package:rotary_parking/components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(27),
              children: [
                Form(
                  key: formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Logo(),
                      const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
                        },
                      ),
                      Container(
                        height: 19,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
                      InkWell(
                        onTap: () async {
                          if (email.text == "") {
                            AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.leftSlide,
                                    title: 'Error',
                                    desc: 'Enter your email')
                                .show();
                            return;
                          }
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email.text);

                            AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.leftSlide,
                                    title: 'Info',
                                    desc:
                                        'Go to your account to reset password')
                                .show();
                          } catch (e) {
                            AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.leftSlide,
                                    title: 'Info',
                                    desc: 'Enter correct account')
                                .show();
                          }
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 10, bottom: 15),
                          child: const Text(
                            "forget password?",
                            style:
                                TextStyle(fontSize: 13.5, color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Button(
                  title: "Login",
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        //final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.text, password: pass.text);

                        setState(() {
                          isLoading = false;
                        });
                        //if (credential.user!.emailVerified) {
                        Navigator.of(context)
                            .pushReplacementNamed("custom_map");
                        //} else {
                        //  return;
                        //}
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    } else {
                      print("not valid");
                    }
                  },
                ),
                Container(
                  height: 17,
                ),
                MaterialButton(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  textColor: Colors.red,
                  height: 48,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    // signInWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login with Google    ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Image.asset("assets/images/g.jpg", width: 30),
                    ],
                  ),
                ),
                Container(
                  height: 17,
                ),
                MaterialButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  height: 48,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    // signInWithApple();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login with Apple    ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Image.asset("assets/images/a.png", width: 45),
                    ],
                  ),
                ),
                Container(
                  height: 17,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: const Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Dont't Have an account? "),
                          TextSpan(
                              text: "Register",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
