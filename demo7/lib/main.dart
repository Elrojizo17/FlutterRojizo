import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tema con Deslizamiento en AppBar',
      debugShowCheckedModeBanner: false,

      // ☀️ Tema claro (azules suaves)
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2196F3), // Azul principal
          onPrimary: Colors.white,
          secondary: Color(0xFF64B5F6), // Azul claro
          background: Color(0xFFF5F7FA), // Fondo gris claro
          onBackground: Color(0xFF1E1E1E), // Texto oscuro
          surface: Colors.white,
          onSurface: Color(0xFF333333),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),

      // 🌙 Tema oscuro (cian petróleo)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00BCD4), // Cian brillante
          onPrimary: Color(0xFF002B36),
          secondary: Color(0xFF26C6DA), // Cian claro
          background: Color(0xFF121212), // Fondo oscuro
          onBackground: Color(0xFFE0E0E0), // Texto claro
          surface: Color(0xFF1E1E1E),
          onSurface: Color(0xFFE0E0E0),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),

      themeMode: _themeMode,

      home: MyHomePage(
        onSwipe: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final VoidCallback onSwipe;
  final bool isDarkMode;

  const MyHomePage({
    super.key,
    required this.onSwipe,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      // AppBar con gesto de deslizamiento
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            onSwipe(); // Cambia el tema al deslizar
          },
          child: AppBar(
            title: Text(isDarkMode ? "🌙 Tema Oscuro" : "☀️ Tema Claro"),
            backgroundColor: theme.primary,
            foregroundColor: theme.onPrimary,
            centerTitle: true,
          ),
        ),
      ),

      body: Container(
        color: theme.background,
        child: Center(
          child: Text(
            "Desliza sobre la barra superior para cambiar el tema 👆",
            style: TextStyle(
              fontSize: 18,
              color: theme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
