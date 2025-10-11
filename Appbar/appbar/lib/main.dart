import 'package:flutter/material.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppBar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 216, 12, 12),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const AppBarExample(),
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({super.key});

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  bool isRed = true; // 🔹 Controla el color actual (rojo o azul)
  Color get appBarColor =>
      isRed ? const Color.fromARGB(255, 236, 14, 14) : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text('Mi Demo'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menú principal',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Acá se muestra el menú más chimba')),
            );
          },
        ),
        actions: <Widget>[
          // 🔘 Switch para cambiar color del AppBar
          Switch(
            value: isRed,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.blue,
            onChanged: (bool value) {
              setState(() {
                isRed = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Color cambiado a ${value ? "rojo" : "azul"}'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: appBarColor,
                ),
              );
            },
          ),

          // ➡️ Botón para navegar a otra página
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Ir a la siguiente página',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const NextPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              'Esta es la página principal',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next page')),
      body: const Center(
        child: Text(
          'This is the next page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
