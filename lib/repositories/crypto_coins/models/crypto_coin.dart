import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String symbol;
  final String name;
  final String logoUrl;
  final double priceUsd;

  const CryptoCoin({
    required this.symbol,
    required this.name,
    required this.logoUrl,
    required this.priceUsd,
  });

  factory CryptoCoin.fromJson(Map<String, dynamic> json) {
    return CryptoCoin(
      symbol: json['SYMBOL'] ?? '',
      name: json['NAME'] ?? '',
      logoUrl: json['LOGO_URL'] ?? '',
      priceUsd: (json['PRICE_USD'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [symbol, name, logoUrl, priceUsd];
}
