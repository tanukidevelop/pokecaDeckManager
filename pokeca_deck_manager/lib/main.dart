import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'detail.dart';
import 'edit.dart';
import 'add.dart';

void main() {
  runApp(ListApp());
}

// デッキレシピを新規作成する
class CreateDeckRecipeWebviewTest extends StatelessWidget {
  final String url = "https://www.pokemon-card.com/deck/deck.html";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FlutterWebviewPlugin()
            .close(); // Close the plugin so that it doesn't overlay anymore
        return true;
      },
      child: WebviewScaffold(
        appBar: AppBar(
          title: Text("デッキレシピ 新規作成"),
        ),
        url: url,
      ),
    );
  }
}

// デッキレシピを確認する
class DetailDeckRecipeWebviewTest extends StatelessWidget {
  String url;
  DetailDeckRecipeWebviewTest(this.url);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FlutterWebviewPlugin()
            .close(); // Close the plugin so that it doesn't overlay anymore
        return true;
      },
      child: WebviewScaffold(
        appBar: AppBar(
          title: Text("デッキレシピ 確認"),
        ),
        url: url,
      ),
    );
  }
}

class ListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
          primarySwatch: Colors.blue),
      home: MyHomePage(title: 'デッキレシピ 一覧'),
    );
  }
}

// デッキレシピのデータモデル
class DeckRecipeModel {
  String? deckName = "";
  String? deckCode = "";
  String? deckMemo = "";
  String? createDate = "";
  DeckRecipeModel(
      {this.deckName, this.deckCode, this.deckMemo, this.createDate});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DeckRecipeModel> _deckList = [
      DeckRecipeModel(
          deckName: "ハイクラスデッキ インテレオンVmaxデッキ",
          deckCode: "xYcxcx-bj7co1-8D8c8G",
          deckMemo:
              "ハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキ",
          createDate: "2021年6月15日"),
      DeckRecipeModel(
          deckName: "ハイクラスデッキ ゲンガーVmaxデッキ",
          deckCode: "xYcxcx-bj7co1-8D8c8G",
          deckMemo:
              "ハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキ",
          createDate: "2021年6月15日"),
      DeckRecipeModel(
          deckName: "オーロンゲVmaxデッキ",
          deckCode: "xYcxcx-bj7co1-8D8c8G",
          deckMemo:
              "ハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキハイクラスデッキ ゲンガーVmaxデッキ",
          createDate: "2021年6月15日"),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // 中央寄せを解除

        // 左側のアイコン
        leading: IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: () => setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateDeckRecipeWebviewTest()));
            print("tapped");
          }),
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: double.infinity,
                child: Text('デッキレシピが表示されている行を長押し中に移動すると並び替えできます。     　 ',
                    style: TextStyle(fontFamily: 'Code128', fontSize: 10.0),
                    textAlign: TextAlign.right)),
            Flexible(
              //Flexibleでラップ
              child: ReorderableListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  DeckRecipeModel deckModel = _deckList[index];
                  return Card(
                      key: Key(deckModel.deckName.toString()),
                      child: ListTile(
                        title: Text(
                          deckModel.deckName.toString(),
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "デッキコード：" +
                                deckModel.deckCode.toString() +
                                "\n"
                                    "作成日：" +
                                deckModel.createDate.toString(),
                            style: new TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.bold)),
                        trailing: SizedBox(
                          width: 50,
                          child: RaisedButton(
                            child: const Icon(Icons.create_sharp),
                            color: Colors.blue,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              final DeckRecipeModel editDeckModel =
                                  _deckList[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditPage(editDeckModel)),
                              );
                            },
                          ),
                        ),

                        onTap: () {
                          print("onTap called.");
                          final DeckRecipeModel tapDeckModel = _deckList[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(tapDeckModel)),
                          );
                        }, // タップ
                        // onLongPress: () {
                        //   print("onLongPress called.");
                        //   final DeckRecipeModel tapDeckModel = _deckList[index];
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => EditPage(tapDeckModel)),
                        //   );
                        // }, // 長押し
                      ));
                },
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final DeckRecipeModel item = _deckList.removeAt(oldIndex);
                  _deckList.insert(newIndex, item);
                },
              ),
            ),

            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage()));
          print("tapped");
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
