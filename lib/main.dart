import 'package:crypto_currencies_app/app.dart';
import 'package:crypto_currencies_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(
      dio: Dio(
        BaseOptions(
          baseUrl: 'https://data-api.coindesk.com',
          headers: {
            'Authorization':
                'Apikey 038d0ef2c4bdd2006d6af016980bf412a98cee7cc78b57550648c96472421144',
          },
        ),
      ),
    ),
  );
  runApp(const CryptoCurrenciesListApp());
}
