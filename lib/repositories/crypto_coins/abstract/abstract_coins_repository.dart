import 'package:crypto_currencies_app/repositories/crypto_coins/models/models.dart';

abstract class AbstractCoinsRepository {
  Future<CryptoCoinList> getCoinsList({required int page});
}
