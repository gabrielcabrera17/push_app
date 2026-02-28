import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permiso'),
        actions: [
          IconButton(
          onPressed: () {
            //TODO: solicitar permiso de notificaciones
          }, 
          icon: Icon(Icons.settings)
        )
        ],
      ),
      body: _HomeView(
        
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}