import 'package:flutter/material.dart';
import 'data.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  late String titleValue;
  late String descriptionValue;
  late int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pop(
                    context, Data(titleValue, descriptionValue, index));
                index++;
              },
              icon: const Text('Save'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    onChanged: (_titleValue) {
                      titleValue = _titleValue;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                        minLines: 1,
                        maxLines: 5,
                        maxLengthEnforced: true,
                        onChanged: (_descriptionValue) {
                          descriptionValue = _descriptionValue;
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
