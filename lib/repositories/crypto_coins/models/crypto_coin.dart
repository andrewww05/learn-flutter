class CryptoCoin {
  final String symbol;
  final String name;
  final String logoUrl;
  final double priceUsd;

  CryptoCoin({
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
}
