import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'main.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class DetailPage extends StatelessWidget {
  DeckRecipeModel deckModel;
  DetailPage(this.deckModel);

  @override
  Widget build(BuildContext context) {
    Future<void> _shareImageFromUrl() async {
      try {
        var request = await HttpClient().getUrl(Uri.parse(
            'https://www.pokemon-card.com/deck/deckView.php/deckID/' +
                deckModel.deckCode.toString() +
                '.png'));
        var response = await request.close();
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
        Share.files(
            'Share images',
            {
              'Deckimage.png': bytes,
            },
            '*/*',
            text: 'デッキ名:' +
                deckModel.deckName.toString() +
                "\nデッキコード:" +
                deckModel.deckCode.toString());
      } catch (e) {
        print('error: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('デッキレシピ 詳細'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share), onPressed: () => {_shareImageFromUrl()}),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            SizedBox(
                width: double.infinity,
                child: Text(' ▼デッキ名',
                    style: TextStyle(
                        fontFamily: 'Code128',
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left)),
            SizedBox(
                width: double.infinity,
                child: Text(' ' + deckModel.deckName.toString(),
                    style: TextStyle(
                        fontFamily: 'Code128',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left)),
            Spacer(
              flex: 5,
            ),
            new Divider(color: Colors.black),
            SizedBox(
                width: double.infinity,
                child: Text(' ▼デッキコード',
                    style: TextStyle(
                        fontFamily: 'Code128',
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left)),
            SizedBox(
                width: double.infinity,
                child: Text(' ' + deckModel.deckCode.toString(),
                    style: TextStyle(
                        fontFamily: 'Code128',
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left)),
            Spacer(
              flex: 5,
            ),
            new Divider(color: Colors.black),
            SizedBox(
                width: double.infinity,
                child: Text(' ▼メモ',
                    style: TextStyle(
                        fontFamily: 'Code128',
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left)),
            SizedBox(
                width: double.infinity,
                height: 100, // Widgetの幅を指定
                child: Text(' ' + deckModel.deckMemo.toString(),
                    style: TextStyle(
                        fontFamily: 'Code128',
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left)),
            Spacer(
              flex: 5,
            ),
            new Divider(color: Colors.black),
            Image.network(
                'https://www.pokemon-card.com/deck/deckView.php/deckID/' +
                    deckModel.deckCode.toString() +
                    '.png'),
            Spacer(
              flex: 5,
            ),
            new Divider(color: Colors.black),
            Spacer(
              flex: 5,
            ),
            RaisedButton(
              child: const Text('ブラウザでデッキレシピを開く'),
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
