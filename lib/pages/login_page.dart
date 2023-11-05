import 'package:flutter/material.dart';
import 'package:note_book/pages/authenticate_page.dart';
import 'package:note_book/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                bool auth = await Authenticate.authentication();
                print("can authenticate $auth");
                if (auth) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              icon: Icon(Icons.fingerprint),
              label: Text("Authenticate finger"),
            ),
          ],
        ),
      ),
    );
  }
}
