import 'package:flutter/material.dart';

final List<int> _items = List<int>.generate(51, (int index) => index);

void main() => runApp(const AppBarApp());

class AppBarApp extends StatefulWidget {
  const AppBarApp({super.key});

  @override
  State<AppBarApp> createState() => _AppBarAppState();
}

class _AppBarAppState extends State<AppBarApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorSchemeSeed: isDarkMode ? Colors.blueGrey : Colors.blue,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,
    );

    return MaterialApp(
      theme: theme,
      home: AppBarExample(
        isDarkMode: isDarkMode,
        onThemeChanged: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppBarExample extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppBarExample({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Colores con contraste según el modo
    final Color backgroundColor =
        widget.isDarkMode ? colorScheme.surfaceVariant : colorScheme.background;
    final Color appBarColor =
        widget.isDarkMode ? colorScheme.primaryContainer : colorScheme.primary;
    final Color textColor =
        widget.isDarkMode ? Colors.white : Colors.black87;
    final Color buttonTextColor =
        widget.isDarkMode ? Colors.white : Colors.black;
    final Color gridItemTextColor =
        widget.isDarkMode ? Colors.white70 : Colors.black87;

    final Color oddItemColor =
        widget.isDarkMode ? Colors.grey[800]! : colorScheme.primary.withOpacity(0.15);
    final Color evenItemColor =
        widget.isDarkMode ? Colors.grey[700]! : colorScheme.primary.withOpacity(0.25);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: Text(
          'Personalización visual',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? colorScheme.shadow : null,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: textColor,
            ),
            tooltip: widget.isDarkMode ? 'Modo claro' : 'Modo oscuro',
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
          ),
        ],
      ),

      body: GridView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Center(
              child: Text(
                'Desliza para ver los cambios visuales.',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          final bool isEven = _items[index].isEven;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: isEven ? evenItemColor : oddItemColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isEven ? Icons.star : Icons.favorite,
                  color: widget.isDarkMode
                      ? Colors.amberAccent
                      : (isEven ? Colors.orange : Colors.pinkAccent),
                  size: 36,
                ),
                const SizedBox(height: 6),
                Text(
                  'Item $index',
                  style: TextStyle(
                    color: gridItemTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: BottomAppBar(
        color: appBarColor.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            overflowSpacing: 5.0,
            children: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondaryContainer,
                ),
                onPressed: () {
                  setState(() {
                    shadowColor = !shadowColor;
                  });
                },
                icon: Icon(
                  shadowColor ? Icons.visibility_off : Icons.visibility,
                  color: buttonTextColor,
                ),
                label: Text(
                  'Sombra',
                  style: TextStyle(color: buttonTextColor),
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.tertiaryContainer,
                ),
                onPressed: () {
                  if (scrolledUnderElevation == null) {
                    setState(() {
                      scrolledUnderElevation = 4.0;
                    });
                  } else {
                    setState(() {
                      scrolledUnderElevation = scrolledUnderElevation! + 1.0;
                    });
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Elevación actual: ${scrolledUnderElevation!.toStringAsFixed(1)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: colorScheme.primary,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  'Elevación: ${scrolledUnderElevation ?? 'default'}',
                  style: TextStyle(color: buttonTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

