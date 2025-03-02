import 'package:crypto_currencies_app/models/models.dart';

abstract class AbstractCoinsRepository {
  Future<CryptoCoinList> getCoinsList(int page);
}
