import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'networking.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coin = CoinData();

  DropdownButton<String> getAndroidDropdownButton() {
    //---- Это метод создан для Платформы Android -- он создает наш выпадающий список
    List<DropdownMenuItem<String>> dropDownItem = []; // Создаем массив дропдаунов с ребенком Text(String) для того чтобы вставлять наши названия выпадающего списка в него
    for (String currency in currenciesList) {
      // тут мы инициировали массив // в curren

      var newItem = DropdownMenuItem(
        // создаем выпадающий список и указываем каждое название в него
        child: Text(currency),
        value: currency,
      );
      dropDownItem.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItem,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            print(selectedCurrency);
          },
        );
      },
    );
  }

  CupertinoPicker getIosPicket() {
    //---- Это метод для IOS Платформы -- он создает выпадающий список
    List<Text> cupertinoItem = [];
    for (String currency in currenciesList) {
      cupertinoItem.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          print(selectedCurrency);
        });
      },
      children: cupertinoItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    var contextd = coin.getCoinData();
    var x = coin.updateUi(contextd);
    print(x);
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0, // это по сути и есть количество тени
              shape: RoundedRectangleBorder(
                // это у нас форма нашей кнопки
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //  child: Padding(
            //  padding: const EdgeInsets.symmetric(horizontal: 190.0),
            child: Platform.isIOS ? getIosPicket() : getAndroidDropdownButton(),
          ),
          // ),
        ],
      ),
    );
  }
}
