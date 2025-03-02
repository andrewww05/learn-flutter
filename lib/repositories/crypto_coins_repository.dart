import 'package:dio/dio.dart';
import 'package:crypto_currencies_app/models/models.dart';

class CryptoCoinsRepository {
  final _api = Dio(
    BaseOptions(
      baseUrl: 'https://data-api.coindesk.com',
      headers: {
        'Authorization':
            'Apikey 038d0ef2c4bdd2006d6af016980bf412a98cee7cc78b57550648c96472421144',
      },
    ),
  );

  Future<CryptoCoinList> getCoinsList(int page) async {
    final response = await _api.get(
      '/asset/v1/top/list?page=$page&page_size=10&sort_by=CIRCULATING_MKT_CAP_USD&sort_direction=DESC&groups=ID,BASIC,SUPPLY,PRICE,MKT_CAP,VOLUME,CHANGE,TOPLIST_RANK&toplist_quote_asset=USD',
    );

    final json = response.data as Map<String, dynamic>;

    CryptoCoinList coinList = CryptoCoinList.fromJson(json);

    return coinList;
  }
}
