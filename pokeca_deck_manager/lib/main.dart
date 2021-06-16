import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 追記する
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

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
      initialRoute: '/',
      routes: {
        '/next': (context) => AddPage(),
      },
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

  DeckRecipeModel.fromJson(Map<String, dynamic> json)
      : deckName = json['deckName'],
        deckCode = json['deckCode'],
        deckMemo = json['deckMemo'],
        createDate = json['createDate'];

  Map<String, dynamic> toJson() => {
        "deckName": deckName,
        "deckCode": deckCode,
        "deckMemo": deckMemo,
        "createDate": createDate
      };
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<DeckRecipeModel> _deckList = [];
  List<DeckRecipeModel> _deckList = [
    DeckRecipeModel(
        deckName: "ハイクラスデッキ インテレオンVmaxデッキ",
        deckCode: "xYcxcx-bj7co1-8D8c8G",
        deckMemo:
            "強さだけを追求し、最高の一撃を極めるバトルスタイルである、「いちげき」のカードを中心に構築されたデッキ。「いちげき」のカード同士で相乗効果を生みながら、ゲンガーVMAXのワザで大ダメージを与え、相手をきぜつさせる動きが強力！",
        createDate: "2021年5月28日"),
    DeckRecipeModel(
        deckName: "ハイクラスデッキ ゲンガーVmaxデッキ",
        deckCode: "MpyXMR-GqDfQq-pSpUpE",
        deckMemo:
            "「ハイクラスデッキ インテレオンVMAX」は、予測不可能な動きで敵の虚をついて、柔軟で鋭いワザを浴びせかけるバトルスタイルである、「れんげき」のカードを中心に構築されたデッキ。「れんげき」のカード同士で相乗効果を生みながら、インテレオンVMAXの特性やワザを使いこなすと強力！",
        createDate: "2021年5月28日")
  ];

  void _editList(Map<String, dynamic> map, int index) {
    setState(() async {
      DeckRecipeModel editDeckModel = _deckList[index];
      editDeckModel.deckName = map["deckName"];
      editDeckModel.deckCode = map["deckCode"];
      editDeckModel.deckMemo = map["deckMemo"];

      // 保存
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String entriesJson =
          json.encode(_deckList.map((entry) => entry.toJson()).toList());
      prefs.setString('deckList', entriesJson);
    });
  }

  Future<void> _AddList(DeckRecipeModel deckModel) async {
    setState(() {
      _deckList.add(deckModel);
    });
    // 保存
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String entriesJson =
        json.encode(_deckList.map((entry) => entry.toJson()).toList());
    prefs.setString('deckList', entriesJson);
  }

  Future<void> _SwapList(int oldIndex, int newIndex) async {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final DeckRecipeModel item = _deckList.removeAt(oldIndex);
      _deckList.insert(newIndex, item);
    });
    // 保存
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String entriesJson =
        json.encode(_deckList.map((entry) => entry.toJson()).toList());
    prefs.setString('deckList', entriesJson);
  }

  // 初回のみアプリ内のデータを読み取っている
  _readSaveList() async {
    // 読み取り
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedEntriesJson = prefs.getString("deckList");
    final List<dynamic> entriesDeserialized = json.decode(savedEntriesJson!);
    List<DeckRecipeModel> deserializedEntries = entriesDeserialized
        .map((json) => DeckRecipeModel.fromJson(json))
        .toList();
    setState(() {
      _deckList = deserializedEntries;
    });
  }

  //ここが重要
  @override
  void initState() {
    //アプリ起動時に一度だけ実行される
    _readSaveList();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                    'デッキレシピを長押し中に移動すると並び替え,\nデッキレシピをスワイプすると削除ができます。     　 ',
                    style: TextStyle(fontFamily: 'Code128', fontSize: 10.0),
                    textAlign: TextAlign.right)),
            Flexible(
              //Flexibleでラップ
              child: ReorderableListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: _deckList.length,
                itemBuilder: (BuildContext context, int index) {
                  DeckRecipeModel deckModel = _deckList[index];
                  return Dismissible(
                    key: Key("$index"),
                    onDismissed: (direction) async {
                      setState(() {
                        // スワイプされた要素をデータから削除する
                        _deckList.removeAt(index);
                      });
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final String entriesJson = json.encode(
                          _deckList.map((entry) => entry.toJson()).toList());
                      prefs.setString('deckList', entriesJson);
                      // スワイプ方向がendToStart（画面左から右）の場合の処理
                      if (direction == DismissDirection.endToStart) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("削除しました")));
                        // スワイプ方向がstartToEnd（画面右から左）の場合の処理
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("登録しました")));
                      }
                    },
                    child: Card(
                        key: Key("$index"),
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
                                            EditPage(editDeckModel))).then(
                                    (result) => {
                                          result.cast<String, dynamic>(),
                                          _editList(result, index)
                                        });
                              },
                            ),
                          ),

                          onTap: () {
                            print("onTap called.");
                            final DeckRecipeModel tapDeckModel =
                                _deckList[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(tapDeckModel)),
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
                        )),
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  _SwapList(oldIndex, newIndex);
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
          child: Icon(Icons.add),
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/next');
            final dict = result as Map;
            final deckModel = DeckRecipeModel(
                deckName: result["deckName"].toString(),
                deckCode: result["deckCode"].toString(),
                deckMemo: result["deckMemo"].toString(),
                createDate: result["createDate"].toString());
            _AddList(deckModel);
          }),
    );
  }
}
