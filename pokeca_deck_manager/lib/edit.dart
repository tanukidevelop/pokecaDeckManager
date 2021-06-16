import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'main.dart';

class EditPage extends StatelessWidget {
  DeckRecipeModel deckModel;
  EditPage(this.deckModel);

  @override
  Widget build(BuildContext context) {
    String deckName = deckModel.deckName.toString();
    String deckCode = deckModel.deckCode.toString();
    String deckMemo = deckModel.deckMemo.toString();
    String createDate = deckModel.createDate.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('デッキレシピ 編集'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 5,
            ),
            TextFormField(
              controller: TextEditingController(text: deckModel.deckName),
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
              controller: TextEditingController(text: deckModel.deckCode),
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
              controller: TextEditingController(text: deckModel.deckMemo),
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
                  child: const Text('　　　更新　　　'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Map<String, dynamic> map = {
                      'deckName': deckName,
                      'deckCode': deckCode,
                      'deckMemo': deckMemo,
                    };
                    Navigator.pop(context, map);
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
