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
  // Estado inicial: tema claro
  ThemeMode _themeMode = ThemeMode.light;

  // Cambia entre claro y oscuro
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tema Claro y Oscuro',
      debugShowCheckedModeBanner: false,

      // ☀️ Tema claro (Paleta azul suave y profesional)
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2196F3), // Azul principal
          onPrimary: Colors.white,
          secondary: Color(0xFF64B5F6), // Azul claro
          background: Color(0xFFF5F7FA), // Fondo gris muy claro
          onBackground: Color(0xFF1E1E1E), // Texto oscuro
          surface: Colors.white,
          onSurface: Color(0xFF333333),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),

      // 🌙 Tema oscuro (Paleta azul petróleo y cian)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00BCD4), // Cian brillante
          onPrimary: Color(0xFF002B36), // Fondo del botón
          secondary: Color(0xFF26C6DA), // Cian claro
          background: Color(0xFF121212), // Fondo principal
          onBackground: Color(0xFFE0E0E0), // Texto claro
          surface: Color(0xFF1E1E1E),
          onSurface: Color(0xFFE0E0E0),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),

      // Tema actual
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
        title: Text(isDarkMode ? "🌙 Tema Oscuro" : "☀️ Tema Claro"),
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: onToggleTheme,

          // 🌟 Ícono animado
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 900),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: Tween(begin: 0.75, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              key: ValueKey<bool>(isDarkMode),
              size: 32,
            ),
          ),

          // Texto dinámico
          label: Text(
            isDarkMode ? "Cambiar a modo claro" : "Cambiar a modo oscuro",
          ),

          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primary,
            foregroundColor: theme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
