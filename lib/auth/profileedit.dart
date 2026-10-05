import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotary_parking/components/textformfield.dart';

class ProfileEdit extends StatefulWidget {
  final String oldName;
  final String oldMail;
  final String userId;
  const ProfileEdit({
    super.key,
    required this.oldName,
    required this.oldMail,
    required this.userId,
  });

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController uid = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> edit() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //print("Error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.oldName;
    email.text = widget.oldMail;
    uid.text = widget.userId;
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    uid.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile edit"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage("assets/images/login.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.camera_enhance_rounded,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormdesign(
                      enabled: true,
                      labeltext: "username",
                      mycontroller: name,
                      validator: (val) {
                        if (val == "") {
                          return "Can't Be Empty";
                        }
                        return null;
                      },
                      obscuretext: false,
                    ),
                    const SizedBox(height: 13),
                    TextFormdesign(
                      enabled: false,
                      labeltext: "E-mail",
                      mycontroller: email,
                      validator: (val) {
                        if (val == "") {
                          return "Can't Be Empty";
                        }
                        return null;
                      },
                      obscuretext: false,
                    ),
                    const SizedBox(height: 13),
                    TextFormdesign(
                      enabled: false,
                      labeltext: "Password",
                      mycontroller: uid,
                      validator: (val) {
                        if (val == "") {
                          return "Can't Be Empty";
                        }
                        return null;
                      },
                      obscuretext: true,
                    ),
                    const SizedBox(height: 56),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          edit();
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
