import 'package:crypto_currencies_app/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_currencies_app/features/crypto_list/crypto_list.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => CryptoListScreen(),
  '/coin': (context) => CryptoCoinScreen(),
};
