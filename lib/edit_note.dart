import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notebook/data.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  bool _showEditing = false;
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Data;

    late String titleValue;
    late String descriptionValue;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          _showEditing == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      item.title = titleValue;
                      item.description = descriptionValue;
                      _showEditing = false;
                    });
                  },
                  icon: const Text('Save'))
              : IconButton(
                  onPressed: () {
                    // TUTAJ NAV POP Z ITEM.TIT I ITEM.VAL
                    Navigator.pop(
                        context, Data(item.title, item.description, item.id));
                  },
                  icon: const FittedBox(child: Text('Back')))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Column(children: <Widget>[
                const Text('Edit note'),
                Switch.adaptive(
                  value: _showEditing,
                  onChanged: (val) {
                    setState(() {
                      _showEditing = val;
                    });
                  },
                ),
              ])
            ]),
            _showEditing
                ? Column(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: item.title,
                              ),
                              onChanged: (_titleValue) {
                                titleValue = _titleValue;
                              },
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: item.description,
                                  ),
                                  minLines: 1,
                                  maxLines: 10,
                                  onChanged: (_descriptionValue) {
                                    descriptionValue = _descriptionValue;
                                  },
                                )),
                          ],
                        ),
                      ),
                      Platform.isIOS
                          ? Container()
                          : FloatingActionButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Zapisano'),
                                  duration: Duration(seconds: 2),
                                ));
                                setState(() {
                                  item.title = titleValue;
                                  item.description = descriptionValue;
                                  _showEditing = false;
                                });
                              },
                              child: const Text("Save",
                                  style: TextStyle(fontSize: 10)),
                            ),
                    ],
                  )
                : Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(''),
                          Text(item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(''),
                          Text(item.description),
                          Center(
                            child: Platform.isIOS
                                ? Container()
                                : FloatingActionButton(
                                    onPressed: () {
                                      // TUTAJ NAV POP Z ITEM.TIT I ITEM.VAL
                                      Navigator.pop(
                                          context,
                                          Data(item.title, item.description,
                                              item.id));
                                    },
                                    child: const Text("Back",
                                        style: TextStyle(fontSize: 10)),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
