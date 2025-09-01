import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listado de Lenguajes de Programación',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomePage(),
    );
  }
}

/// Vistas disponibles
enum HomeView { lista, tarjetas }

/// Modelo simple para cada lenguaje
class Language {
  final String name;
  final int year;
  final String creator;
  final IconData icon;

  const Language({
    required this.name,
    required this.year,
    required this.creator,
    required this.icon,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeView _current = HomeView.lista;

  static const languages = <Language>[
    Language(
      name: 'Python',
      year: 1991,
      creator: 'Guido van Rossum',
      icon: Icons.code,
    ),
    Language(
      name: 'Java',
      year: 1995,
      creator: 'James Gosling',
      icon: Icons.code,
    ),
    Language(
      name: 'JavaScript',
      year: 1995,
      creator: 'Brendan Eich',
      icon: Icons.code,
    ),
    Language(name: 'C#', year: 2000, creator: 'Microsoft', icon: Icons.code),
    Language(
      name: 'Go',
      year: 2009,
      creator: 'Robert Griesemer, Rob Pike, Ken Thompson',
      icon: Icons.code,
    ),
    Language(
      name: 'Rust',
      year: 2010,
      creator: 'Graydon Hoare',
      icon: Icons.code,
    ),
    Language(
      name: 'Kotlin',
      year: 2011,
      creator: 'JetBrains',
      icon: Icons.code,
    ),
    Language(
      name: 'Dart',
      year: 2011,
      creator: 'Lars Bak, Kasper Lund',
      icon: Icons.code,
    ),
  ];

  // Mapeo de nombre de lenguaje a nombre de archivo de imagen
  static const Map<String, String> languageImages = {
    'Python': 'python.jpg',
    'Java': 'java.jpg',
    'JavaScript': 'js.jpg',
    'C#': 'c#.jpg',
    'Go': 'go.jpg',
    'Rust': 'rust.jpg',
    'Kotlin': 'kotlin.jpg',
    'Dart': 'dart.jpg',
  };

  @override
  Widget build(BuildContext context) {
    final title = _current == HomeView.lista
        ? 'Lista de Lenguajes'
        : 'Lenguajes (Tarjetas)';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Acerca de',
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Lenguajes de Programación',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.code),
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
                image: DecorationImage(
                  image: AssetImage('assets/img/lenguajes.png'),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              child: Text(
                'Lenguajes de Programación',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt_outlined),
              title: const Text('Ver como lista'),
              selected: _current == HomeView.lista,
              onTap: () {
                setState(() {
                  _current = HomeView.lista;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined),
              title: const Text('Ver como tarjetas'),
              selected: _current == HomeView.tarjetas,
              onTap: () {
                setState(() {
                  _current = HomeView.tarjetas;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _current == HomeView.lista
            ? _buildListView(context)
            : _buildCardView(context),
      ),
    );
  }

  /// Vista 1: Lista con ListTiles
  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      key: const ValueKey('lista'),
      itemCount: languages.length,
      separatorBuilder: (_, __) => Divider(
        height: 0,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      itemBuilder: (context, i) {
        final lang = languages[i];
        return ListTile(
          leading: CircleAvatar(child: Icon(lang.icon)),
          title: Text(lang.name),
          subtitle: Text('Año: ${lang.year} · Creador: ${lang.creator}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showSnack(context, 'Elegiste ${lang.name}'),
        );
      },
    );
  }

  /// Vista 2: "CardView" como Grid de Cards
  Widget _buildCardView(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900 ? 4 : (width > 600 ? 3 : 2);

    return GridView.builder(
      key: const ValueKey('tarjetas'),
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 4 / 3,
      ),
      itemCount: languages.length,
      itemBuilder: (context, i) {
        final lang = languages[i];
        final imgFile = languageImages[lang.name] ?? 'lenguajes.png';
        return Card(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage('assets/img/$imgFile'),
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListTile(
                leading: Icon(lang.icon),
                title: Text(lang.name),
                subtitle: Text('Año: ${lang.year}\nCreador: ${lang.creator}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _showSnack(context, 'Más de ${lang.name}'),
                    child: const Text('Ver más'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }
}
