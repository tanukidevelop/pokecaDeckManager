import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'main.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  child: const Text('　　新規作成　　'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {},
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
