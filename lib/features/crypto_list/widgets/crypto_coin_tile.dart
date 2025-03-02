import 'package:crypto_currencies_app/models/models.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final theme = Theme.of;

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: SvgPicture.asset(
      //   'svg/bitcoin_logo.svg',
      //   semanticsLabel: 'Bitcoin',
      //   height: 35,
      //   width: 35,
      // ),
      leading: Image.network(
        coin.logoUrl,
        semanticLabel: coin.name,
        height: 35,
        width: 35,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, '/coin', arguments: coin.name);
      },
      title: Text(coin.name, style: theme(context).textTheme.bodyMedium),
      subtitle: Text(
        '\$${coin.priceUsd}',
        style: theme(context).textTheme.bodySmall,
      ),
    );
  }
}
