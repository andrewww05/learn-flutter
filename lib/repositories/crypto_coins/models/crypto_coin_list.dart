import 'package:crypto_currencies_app/repositories/crypto_coins/models/models.dart';
import 'package:equatable/equatable.dart';

class CryptoCoinListStats extends Equatable {
  final int page;
  final int pageSize;
  final int count;

  const CryptoCoinListStats({
    required this.page,
    required this.pageSize,
    required this.count,
  });

  factory CryptoCoinListStats.fromJson(Map<String, dynamic> json) {
    return CryptoCoinListStats(
      page: json['PAGE'] ?? 1,
      pageSize: json['PAGE_SIZE'] ?? 10,
      count: json['TOTAL_ASSETS'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [page, pageSize, count];
}

class CryptoCoinList extends Equatable {
  final List<CryptoCoin> items;
  final CryptoCoinListStats pagination;

  const CryptoCoinList({required this.items, required this.pagination});

  factory CryptoCoinList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['Data']['LIST'] ?? [];

    return CryptoCoinList(
      pagination: CryptoCoinListStats.fromJson(json['Data']['STATS']),
      items: list.map((item) => CryptoCoin.fromJson(item)).toList(),
    );
  }

  @override
  List<Object?> get props => [items, pagination];
}
