import 'package:car_collection/view/home_view.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                
              ),
              FilledButton(child: Text("Register"), onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeView();
                }, ));
              },),
            ],
          ),
        ),
      ),
    );
  }
}