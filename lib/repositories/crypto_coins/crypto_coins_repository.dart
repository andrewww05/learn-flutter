import 'package:crypto_currencies_app/repositories/crypto_coins/abstract/abstract.dart';
import 'package:crypto_currencies_app/repositories/crypto_coins/models/models.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;

  CryptoCoinsRepository({required this.dio});

  @override
  Future<CryptoCoinList> getCoinsList({required int page}) async {
    final response = await dio.get(
      '/asset/v1/top/list?page=$page&page_size=10&sort_by=CIRCULATING_MKT_CAP_USD&sort_direction=DESC&groups=ID,BASIC,SUPPLY,PRICE,MKT_CAP,VOLUME,CHANGE,TOPLIST_RANK&toplist_quote_asset=USD',
    );

    final json = response.data as Map<String, dynamic>;

    CryptoCoinList coinList = CryptoCoinList.fromJson(json);

    return coinList;
  }
}
