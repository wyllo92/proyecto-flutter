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
        // AppBar personalizado con gradiente
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

      // NavigationDrawer (Material 3) dentro del Drawer del Scaffold
      drawer: Drawer(
        child: SafeArea(
          child: NavigationDrawer(
            selectedIndex: _current == HomeView.lista ? 0 : 1,
            onDestinationSelected: (index) {
              Navigator.of(context).pop(); // cierra el drawer
              setState(() {
                _current = index == 0 ? HomeView.lista : HomeView.tarjetas;
              });
            },
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  'Navegación',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.list_alt_outlined),
                selectedIcon: Icon(Icons.list_alt),
                label: Text('Ver como lista'),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view),
                label: Text('Ver como tarjetas'),
              ),
            ],
          ),
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
        return Card(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () => _showSnack(context, 'Elegiste ${lang.name}'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(lang.icon, size: 28),
                  const SizedBox(height: 12),
                  Text(
                    lang.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Año: ${lang.year}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Creador: ${lang.creator}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FilledButton.tonal(
                      onPressed: () =>
                          _showSnack(context, 'Más de ${lang.name}'),
                      child: const Text('Ver más'),
                    ),
                  ),
                ],
              ),
            ),
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
