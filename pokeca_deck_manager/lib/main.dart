import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(MyApp());
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

class MyApp extends StatelessWidget {
  List<DeckRecipeModel> _deckList = [
    DeckRecipeModel(
        deckName: "1", deckCode: "11", deckMemo: "111", createDate: "1111"),
    DeckRecipeModel(
        deckName: "2", deckCode: "22", deckMemo: "222", createDate: "2222"),
    DeckRecipeModel(
        deckName: "3", deckCode: "33", deckMemo: "333", createDate: "3333")
  ];

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
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => setState(() {
              // _count++;
            }),
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () => setState(() {
              // _count--;
            }),
          ),
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
                  return Card(
                      child: ListTile(
                    title: Text("デッキ名：なんだかんだほんにゃ"),
                    subtitle:
                        Text("デッキコード:asasasa-asasasa-asasasas  作成日:2021年6月15日"),
                  ));
                },
                itemCount: 10,
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
