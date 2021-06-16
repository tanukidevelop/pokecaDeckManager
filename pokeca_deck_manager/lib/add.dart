import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'main.dart';
import 'package:intl/intl.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String deckName = "";
    String deckCode = "";
    String deckMemo = "";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('新規デッキレシピ'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 5,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // 外枠付きデザイン
                filled: true, // fillColorで指定した色で塗り潰し
                fillColor: Colors.white,
                labelText: "デッキ名",
              ),
              onChanged: (text) {
                deckName = text;
              },
            ),

            Spacer(
              flex: 5,
            ),
            Spacer(
              flex: 5,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // 外枠付きデザイン
                filled: true, // fillColorで指定した色で塗り潰し
                fillColor: Colors.white,
                labelText: "デッキコード",
              ),
              onChanged: (text) {
                deckCode = text;
              },
            ),
            Spacer(
              flex: 5,
            ),
            Spacer(
              flex: 5,
            ),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // 外枠付きデザイン
                filled: true, // fillColorで指定した色で塗り潰し
                fillColor: Colors.white,
                labelText: "メモ",
              ),
              onChanged: (text) {
                deckMemo = text;
              },
            ),
            Spacer(
              flex: 5,
            ),
            Spacer(
              flex: 5,
            ),
            Spacer(
              flex: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 30,
                ),
                RaisedButton(
                  child: const Text('　　新規作成　　'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    DateTime now = DateTime.now();
                    DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
                    String date = outputFormat.format(now);
                    print(date);
                    Map<String, String> deckDict = {
                      'deckName': deckName,
                      'deckCode': deckCode,
                      'deckMemo': deckMemo,
                      'createDate': date,
                    };
                    Navigator.pop(context, deckDict);
                  },
                ),
                Spacer(
                  flex: 5,
                ),
                Spacer(
                  flex: 30,
                ),
              ],
            ),

            Spacer(flex: 100),

            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
    );
  }
}
