import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        // add car

      },
      backgroundColor: const Color.fromARGB(255, 251, 120, 163),
      child: Icon(Icons.add)),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Car Collection"),
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                  Icon(Icons.car_rental),
                  Text("Start building your dream garage!"),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home), 
            label: "Home"),

 NavigationDestination(
            icon: Icon(Icons.favorite), 
            label: "Favorites"),
            
             NavigationDestination(
            icon: Icon(Icons.person), 
            label: "Profile"),
        ]
          
      ),
    );
  }
}