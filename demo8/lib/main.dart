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
      title: 'Tema Gesto Claro / Oscuro',
      debugShowCheckedModeBanner: false,

      // 🌞 Tema claro (basado en “Gesto Claro”)
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2196F3), // Azul brillante AppBar
          onPrimary: Colors.white, // Texto blanco en AppBar
          secondary: Color(0xFF64B5F6), // Azul secundario más suave
          onSecondary: Colors.white,
          background: Color(0xFFF4F6F8), // Gris muy claro del fondo
          onBackground: Color(0xFF1C1B1F), // Texto oscuro
          surface: Colors.white, // Tarjetas, botones
          onSurface: Color(0xFF1C1B1F),
          error: Color(0xFFB00020),
          onError: Colors.white,
        ),
        useMaterial3: true,
      ),

      // 🌙 Tema oscuro (basado en “Gesto Oscuro”)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00BCD4), // Cian brillante AppBar
          onPrimary: Colors.black, // Texto oscuro sobre cian
          secondary: Color(0xFF0097A7), // Cian más profundo
          onSecondary: Colors.white,
          background: Color(0xFF121212), // Fondo gris oscuro casi negro
          onBackground: Color(0xFFE0E0E0), // Texto claro
          surface: Color(0xFF1E1E1E),
          onSurface: Color(0xFFE0E0E0),
          error: Color(0xFFCF6679),
          onError: Colors.black,
        ),
        useMaterial3: true,
      ),

      themeMode: _themeMode,

      home: MyHomePage(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const MyHomePage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isDarkMode ? "🌙 Tema Oscuro" : "☀️ Tema Claro",
          style: TextStyle(color: theme.onPrimary),
        ),
        backgroundColor: theme.primary,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: onToggleTheme,
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          label: Text(
            isDarkMode ? "Cambiar a modo claro" : "Cambiar a modo oscuro",
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primary,
            foregroundColor: theme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
      backgroundColor: theme.background,
    );
  }
}

