//import 'dart:js';
import 'package:flutter/material.dart';

class SetNickname extends StatefulWidget {
  const SetNickname({Key? key}) : super(key: key);

  @override
  _SetNicknameState createState() => _SetNicknameState();
}

late String nickname;

class _SetNicknameState extends State<SetNickname> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Text("At first set Your nickname",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 4,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nickname',
                ),
                onChanged: (_nick) {
                  nickname = _nick;
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/homeScreen',
                        arguments: nickname);
                  },
                  child: const Text('Ready'),
                ))
          ],
        ),
      ),
    );
  }
}
