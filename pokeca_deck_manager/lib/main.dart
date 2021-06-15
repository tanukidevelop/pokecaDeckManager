import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'detail.dart';

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
      home: MyHomePage(title: 'デッキレシピ一覧'),
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
          deckMemo: "",
          createDate: "2021年6月15日"),
      DeckRecipeModel(
          deckName: "ハイクラスデッキ ゲンガーVmaxデッキ",
          deckCode: "xYcxcx-bj7co1-8D8c8G",
          deckMemo: "",
          createDate: "2021年6月15日"),
      DeckRecipeModel(
          deckName: "オーロンゲVmaxデッキ",
          deckCode: "xYcxcx-bj7co1-8D8c8G",
          deckMemo: "",
          createDate: "2021年6月15日"),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // 中央寄せを解除

        // 左側のアイコン
        leading: IconButton(
          icon: Image.asset('images/sample.jpg'),
          onPressed: () => setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateDeckRecipeWebviewTest()));
            print("tapped");
          }),
        ),
        title: Text(widget.title),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () => setState(() {
          //     // _count++;
          //   }),
          // ),
          // IconButton(
          //   icon: Icon(Icons.remove),
          //   onPressed: () => setState(() {
          //     // _count--;
          //   }),
          // ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: double.infinity,
                child: Text('デッキレシピが表示されている行を長押しすると編集ができます。     　 ',
                    style: TextStyle(fontFamily: 'Code128', fontSize: 10.0),
                    textAlign: TextAlign.right)),
            Flexible(
              //Flexibleでラップ
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final DeckRecipeModel deckModel = _deckList[index];
                  return Card(
                      child: ListTile(
                    title: Text(
                      deckModel.deckName.toString(),
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("デッキコード：" +
                        deckModel.deckCode.toString() +
                        " 作成日:" +
                        deckModel.createDate.toString()),
                    onTap: () {
                      print("onTap called.");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailPage()),
                      );
                    }, // タップ
                    onLongPress: () {
                      print("onLongPress called.");
                    }, // 長押し
                  ));
                },
                itemCount: _deckList.length,
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
