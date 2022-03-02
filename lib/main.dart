import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebook/create_note.dart';
import 'package:notebook/edit_note.dart';
import 'package:notebook/set_nickname.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey[400],
      ),
      initialRoute: '/',
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
        '/editNote': (context) => const EditNote(),
        '/createNote': (context) => const CreateNote(),
        '/': (context) => const SetNickname(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<Data> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                final newNote = await Navigator.pushNamed(
                  context,
                  "/createNote",
                ) as Data;

                setState(() {
                  notes.add(newNote);
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'hello',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(nickname,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Your notes: '),
                        Text(notes.length.toString()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              //LISTA NOTATEK
              flex: 4,
              child: Card(
                child: notes.isEmpty
                    ? const ListTile(
                        title: Text('Empty'),
                        subtitle: Text('Click + to add Your first note'),
                      )
                    : ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final item = notes[index];

                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Deleted!'),
                                duration: Duration(seconds: 2),
                              ));
                              setState(() {
                                notes.removeAt(index);
                              });
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(item.title),
                                subtitle: Text(item.description),
                                trailing: const Icon(Icons.arrow_left),
                                onTap: () async {
                                  /// KLKIKAM NA TO I WYSYLAM TIT I DESC DO EDYCJI
                                  final dataEdit = await Navigator.pushNamed(
                                      context, '/editNote',
                                      arguments: Data(item.title,
                                          item.description, item.id)) as Data;
                                  setState(() {
                                    notes.add(dataEdit);
                                    notes.removeAt(index);
                                  });
                                },
                              ),
                            ),
                            background: Container(
                              color: Colors.black,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
              )),
        ],
      ),
    );
  }
}
