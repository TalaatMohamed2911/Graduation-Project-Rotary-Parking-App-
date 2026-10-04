import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotary_parking/auth/profileedit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
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
                        Icons.edit,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text("${FirebaseAuth.instance.currentUser!.displayName}"),
              Text("${FirebaseAuth.instance.currentUser!.email}"),
              Text("user id: ${FirebaseAuth.instance.currentUser!.uid}"),
              const SizedBox(height: 7),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileEdit(
                          oldName:
                              "${FirebaseAuth.instance.currentUser!.displayName}",
                          oldMail:
                              "${FirebaseAuth.instance.currentUser!.email}",
                          userId: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      ),
                    );
                  },
                  child: const Text("Edit Profile"),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 15),
              Option(
                title: 'settings',
                icon: Icons.settings,
                onPress: () {},
              ),
              Option(
                title: 'billing details',
                icon: Icons.money,
                onPress: () {},
              ),
              Option(
                title: 'user management',
                icon: Icons.manage_accounts,
                onPress: () {},
              ),
              Option(
                title: 'information',
                icon: Icons.info_rounded,
                onPress: () {},
              ),
              Option(
                title: 'Logout',
                icon: Icons.logout_outlined,
                onPress: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    super.key,
    required this.title,
    required this.onPress,
    required this.icon,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  //final bool endIcon;
  //final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 189, 221, 236)),
        child: Icon(icon),
      ),
      title: Text(title),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blue,
        ),
      ),
    );
  }
}
