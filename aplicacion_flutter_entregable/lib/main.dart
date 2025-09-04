import 'package:flutter/material.dart';

void main() => runApp(const ListTileApp());

class ListTileApp extends StatelessWidget {
  const ListTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListTileExample(),
    );
  }
}

class ListTileExample extends StatefulWidget {
  const ListTileExample({super.key});

  @override
  State<ListTileExample> createState() => _ListTileExampleState();
}

enum HomeView { lista, cards }

class _ListTileExampleState extends State<ListTileExample> {
  int _selectedIndex = 0;
  HomeView _currentView = HomeView.lista;

  // Lista de lenguajes con nombre, descripción, color y nombre de imagen
  static const List<Map<String, dynamic>> languages = [
    {
      'name': 'Python',
      'desc':
          'Lenguaje interpretado, fácil de aprender y muy usado en ciencia de datos, web y automatización.',
      'color': Colors.blue,
      'img': 'python.jpg',
    },
    {
      'name': 'Java',
      'desc':
          'Lenguaje orientado a objetos, popular en aplicaciones empresariales y móviles (Android).',
      'color': Colors.red,
      'img': 'java.jpg',
    },
    {
      'name': 'JavaScript',
      'desc':
          'Lenguaje esencial para desarrollo web, tanto en frontend como backend (Node.js).',
      'color': Colors.amber,
      'img': 'js.jpg',
    },
    {
      'name': 'C#',
      'desc':
          'Lenguaje de Microsoft, muy usado en desarrollo de videojuegos (Unity) y aplicaciones de escritorio.',
      'color': Colors.deepPurple,
      'img': 'c#.jpg',
    },
    {
      'name': 'Go',
      'desc':
          'Lenguaje eficiente y concurrente, ideal para sistemas y servidores.',
      'color': Colors.teal,
      'img': 'go.jpg',
    },
    {
      'name': 'Rust',
      'desc':
          'Lenguaje moderno enfocado en seguridad y rendimiento, usado en sistemas y herramientas.',
      'color': Colors.orange,
      'img': 'rust.jpg',
    },
    {
      'name': 'Kotlin',
      'desc':
          'Lenguaje moderno para Android y multiplataforma, interoperable con Java.',
      'color': Colors.pink,
      'img': 'kotlin.jpg',
    },
    {
      'name': 'Dart',
      'desc':
          'Lenguaje de Google para apps móviles, web y escritorio, base de Flutter.',
      'color': Colors.green,
      'img': 'dart.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lenguajes de Programación')),
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
                ),
              ),
              child: Text(
                'Vistas',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt_outlined),
              title: const Text('Vista Lista'),
              selected: _currentView == HomeView.lista,
              onTap: () {
                setState(() {
                  _currentView = HomeView.lista;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined),
              title: const Text('Vista Cards'),
              selected: _currentView == HomeView.cards,
              onTap: () {
                setState(() {
                  _currentView = HomeView.cards;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentView == HomeView.lista
          ? _buildListView()
          : _buildCardView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: languages.length,
      itemBuilder: (BuildContext context, int index) {
        final lang = languages[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          elevation: index == _selectedIndex ? 4 : 1,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/img/${lang['img']}',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 48),
              ),
            ),
            title: Text(
              lang['name'],
              style: TextStyle(
                color: lang['color'],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(lang['desc']),
            ),
            trailing: Icon(
              index == _selectedIndex
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: lang['color'],
            ),
            selected: index == _selectedIndex,
            selectedTileColor: lang['color'].withOpacity(0.12),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildCardView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 4 / 3,
      ),
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final lang = languages[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/img/${lang['img']}',
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 48),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang['name'],
                      style: TextStyle(
                        color: lang['color'],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(lang['desc'], style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
