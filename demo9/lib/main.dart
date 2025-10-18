import 'package:flutter/material.dart';

List<String> titles = <String>['Cloud', 'Beach', 'Sunny'];

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 🚫 Quita el banner DEBUG
      theme: ThemeData(useMaterial3: true),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar Sample'),
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: const TabBar(
            indicatorColor: Color(0xFF003366), // 💙 Azul indicador activo
            labelColor: Color(0xFF003366), // 💙 Azul texto/ícono activo
            unselectedLabelColor: Colors.black54, // Gris para las inactivas
            tabs: [
              Tab(icon: Icon(Icons.cloud_outlined), text: 'Cloud'),
              Tab(icon: Icon(Icons.beach_access_sharp), text: 'Beach'),
              Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Sunny'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildListView(titles[0], oddItemColor, evenItemColor),
            _buildListView(titles[1], oddItemColor, evenItemColor),
            _buildListView(titles[2], oddItemColor, evenItemColor),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(String title, Color oddColor, Color evenColor) {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          tileColor: index.isOdd ? oddColor : evenColor,
          title: Text('$title $index'),
        );
      },
    );
  }
}

