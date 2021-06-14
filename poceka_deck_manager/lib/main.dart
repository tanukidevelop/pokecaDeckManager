import 'package:flutter/material.dart';
import 'package:poceka_deck_manager/browser_icon_icons.dart';

void main() {
  runApp(MyApp());
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
        primarySwatch: Colors.blue,
      ),
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
          icon: Icon(BrowserIcon.language),
          onPressed: () => setState(() {
            // _count++;
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
            Text(
              'デッキレシピが表示されている行を長押しすると編集ができます',
            ),

            Flexible(
              //Flexibleでラップ
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      child: Text(
                        'デッキ名：$index',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      padding: EdgeInsets.all(20.0),
                    ),
                  );
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
