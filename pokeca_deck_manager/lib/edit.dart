import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'main.dart';

class EditPage extends StatelessWidget {
  DeckRecipeModel deckModel;
  EditPage(this.deckModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('デッキレシピ 編集'),
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
            )),

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
            )),
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
            )),
            Spacer(
              flex: 5,
            ),
            Spacer(
              flex: 5,
            ),
            new Divider(color: Colors.black),
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
                    final String url =
                        'https://www.pokemon-card.com/deck/confirm.html/deckID/' +
                            deckModel.deckCode.toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailDeckRecipeWebviewTest(url)));
                  },
                ),
                Spacer(
                  flex: 5,
                ),
                RaisedButton(
                  child: const Text('デッキレシピ削除'),
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    final String url =
                        'https://www.pokemon-card.com/deck/confirm.html/deckID/' +
                            deckModel.deckCode.toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailDeckRecipeWebviewTest(url)));
                  },
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
