import 'package:flutter/material.dart';
import 'package:poceka_deck_manager/browser_icon_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  List<DeckRecipeModel> _deckList = [
    DeckRecipeModel(
        deckName: "1", deckCode: "11", deckMemo: "111", createDate: "1111"),
    DeckRecipeModel(
        deckName: "2", deckCode: "22", deckMemo: "222", createDate: "2222"),
    DeckRecipeModel(
        deckName: "3", deckCode: "33", deckMemo: "333", createDate: "3333")
  ];

  Widget MyListView() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(_deckList[index].deckName.toString(),
                        style: TextStyle(fontSize: 25)),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(_deckList[index].deckCode.toString(),
                        style: TextStyle(fontSize: 20)),
                  )
                ],
              ));
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: _deckList.length);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ポケモンが表示されている行を長押しすると編集ができます',
            ),

            Flexible(
              //Flexibleでラップ
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int index) {
                    return index % 2 == 0 ? Text('item no: $index') : Divider();
                  }),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
