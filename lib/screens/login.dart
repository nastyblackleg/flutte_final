import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            style: TextButton.styleFrom(
                primary: const Color.fromRGBO(0, 0, 0, 1),
                backgroundColor: const Color.fromRGBO(4, 163, 163, 0.6),
                fixedSize: const Size(189, 37)),
            onPressed: () {},
            child: const Text(''),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: const Color.fromRGBO(0, 0, 0, 1),
                backgroundColor: const Color.fromRGBO(4, 163, 163, 0.6),
                fixedSize: const Size(189, 37)),
            onPressed: () {
              Navigator.pushNamed(context, '/main');
            },
            child: const Text('Login'),
          ),
        ],
      )),
    );
  }
}
