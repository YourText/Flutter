import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ProjectsPage(),
    Text('Editar borrador'),
    Text('Compartidos'),
    Text('Configuracion'),
    Text('Invitar amigos'),
    Text('Nuevo borrador'),
    Text('Nuevo proyecto'),
    NewProjectsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc de Notas'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 5,
            color: Colors.blue,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Proyectos'),
                  onTap: () {
                    _onItemTapped(0);
                  },
                ),
                ListTile(
                  title: const Text('Editar borrador'),
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  title: const Text('Compartidos'),
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
                ListTile(
                  title: const Text('Configuracion'),
                  onTap: () {
                    _onItemTapped(3);
                  },
                ),
                ListTile(
                  title: const Text('Invitar amigos'),
                  onTap: () {
                    _onItemTapped(4);
                  },
                ),
                ListTile(
                  title: const Text('Nuevo borrador'),
                  onTap: () {
                    _onItemTapped(5);
                  },
                ),
                ListTile(
                  title: const Text('Nuevo proyecto'),
                  onTap: () {
                    _onItemTapped(6);
                  },
                ),
                ListTile(
                  title: const Text('Nuevos Proyectos'),
                  onTap: () {
                    _onItemTapped(7);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  int _selectedPage = 0;
  final List<String> _pageTitles = ['Página 1'];
  final List<List<Note>> _pages = [
    [Note(), Note(), Note(), Note()]
  ];

  static const List<Color> _colors = [
    Color(0xFFEFF0EA),
    Color(0xFFB4CABD),
    Color(0xFFFFEAD7),
    Color(0xFFECC8B2),
    Color(0xFFFCB3A4),
  ];

  void _onPageSelected(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  void _addPage() {
    setState(() {
      _pageTitles.add('Página ${_pageTitles.length + 1}');
      _pages.add([Note(), Note(), Note(), Note()]);
    });
  }

  void _editNoteText(int pageIndex, int noteIndex, String newText) {
    setState(() {
      _pages[pageIndex][noteIndex].text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue,
          child: Row(
            children: [
              DropdownButton<int>(
                value: _selectedPage,
                dropdownColor: Colors.blue,
                items: List.generate(_pageTitles.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      _pageTitles[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                onChanged: (int? newIndex) {
                  if (newIndex != null) {
                    _onPageSelected(newIndex);
                  }
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addPage,
                child: const Text('Agregar Página'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Compartir'),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16.0),
            childAspectRatio: 3 / 2,
            children: List.generate(_pages[_selectedPage].length, (index) {
              return Card(
                color: _colors[index % _colors.length],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Titulo ${index + 1}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: 'Escribe algo...',
                            border: InputBorder.none,
                          ),
                          onChanged: (newText) {
                            _editNoteText(_selectedPage, index, newText);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Editar'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Compartir'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class NewProjectsPage extends StatefulWidget {
  const NewProjectsPage({super.key});

  @override
  _NewProjectsPageState createState() => _NewProjectsPageState();
}

class _NewProjectsPageState extends State<NewProjectsPage> {
  int _currentPage = 0;
  final List<String> _pageNames = ['Page 1'];
  final List<List<NewNote>> _notePages = [
    [NewNote(), NewNote(), NewNote(), NewNote()]
  ];

  static const List<Color> _newColors = [
    Color(0xFFFAF3DD),
    Color(0xFFC8D5B9),
    Color(0xFF8FC0A9),
    Color(0xFF68B0AB),
    Color(0xFF4A7C59),
  ];

  void _selectPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _createPage() {
    setState(() {
      _pageNames.add('Page ${_pageNames.length + 1}');
      _notePages.add([NewNote(), NewNote(), NewNote(), NewNote()]);
    });
  }

  void _updateNoteText(int pageIndex, int noteIndex, String newText) {
    setState(() {
      _notePages[pageIndex][noteIndex].text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.green,
          child: Row(
            children: [
              DropdownButton<int>(
                value: _currentPage,
                dropdownColor: Colors.green,
                items: List.generate(_pageNames.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      _pageNames[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                onChanged: (int? newIndex) {
                  if (newIndex != null) {
                    _selectPage(newIndex);
                  }
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _createPage,
                child: const Text('Add Page'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Share'),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16.0),
            childAspectRatio: 4 / 3,
            children: List.generate(_notePages[_currentPage].length, (index) {
              return Card(
                color: _newColors[index % _newColors.length],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Title ${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: 'Write something...',
                            border: InputBorder.none,
                          ),
                          onChanged: (newText) {
                            _updateNoteText(_currentPage, index, newText);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Edit'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Share'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class Note {
  String text = '';
}

class NewNote {
  String text = '';
}